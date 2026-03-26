#include "conv2d.hpp"

inline TFXP FXP_Mult(TFXP a, TFXP b, uint32_t decimalBits = DECIMALS)
{
    TFXP_MULT res = (TFXP_MULT)a * (TFXP_MULT)b;
    res = res >> decimalBits;
    return res;
}

void Conv2D_HW(TFXP *input, TFXP * output, TFXP * coeffs,
      uint32_t numChannels, uint32_t numFilters,
      uint32_t inputWidth, uint32_t inputHeight,
      uint32_t convWidth, uint32_t convHeight)
{
    #pragma HLS INTERFACE m_axi port=input offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=output offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=coeffs offset=slave bundle=gmem1

    #pragma HLS INTERFACE s_axilite port=numFilters
    #pragma HLS INTERFACE s_axilite port=numChannels
    #pragma HLS INTERFACE s_axilite port=inputWidth
    #pragma HLS INTERFACE s_axilite port=inputHeight
    #pragma HLS INTERFACE s_axilite port=convWidth
    #pragma HLS INTERFACE s_axilite port=convHeight
    #pragma HLS INTERFACE s_axilite port=return

    TFXP filterCoeffs[MAX_CHANNELS][MAX_CONV_H][MAX_CONV_W];
    
    #pragma HLS ARRAY_PARTITION variable=filterCoeffs complete dim=2
    #pragma HLS ARRAY_PARTITION variable=filterCoeffs complete dim=3

    TFXP lineBuffer0[128*32];
    TFXP lineBuffer1[128*32];
    TFXP lineBuffer2[128*32];

    #pragma HLS ARRAY_PARTITION variable=lineBuffer0 cyclic factor=3 dim=1
    #pragma HLS ARRAY_PARTITION variable=lineBuffer1 cyclic factor=3 dim=1
    #pragma HLS ARRAY_PARTITION variable=lineBuffer2 cyclic factor=3 dim=1

    loop_filters: 
    for(uint32_t iFilter = 0; iFilter < numFilters; ++iFilter) {

        // Task 2: load filter coeffs into buffer
        loop_load_coeffs_channel: 
        for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

            loop_load_coeffs_y: 
            for(uint32_t cy = 0; cy < convHeight; ++cy) {

                loop_load_coef_x: 
                for(uint32_t cx = 0; cx < convWidth; ++cx) {
                    #pragma HLS PIPELINE II=1
                    filterCoeffs[iChannel][cy][cx] = *(coeffs
                                                    + iFilter*numChannels*convHeight*convWidth
                                                    + iChannel*convHeight*convWidth
                                                    + cy*convWidth
                                                    + cx);
                }
            }
        }

        // Task 3: load input rows, and then convolve
        loop_load_input_rows:
        for(uint32_t y = 0; y < (inputHeight-2); ++y) {

            loop_load_row0:
            for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                
                loop_load_row0_x:
                for(uint32_t x = 0; x < inputWidth; ++x) {

                    #pragma HLS PIPELINE II=1
                    lineBuffer0[iChannel*inputWidth + x] = *(input
                                                        + iChannel*inputHeight*inputWidth
                                                        + (y+0)*inputWidth
                                                        + x);
                }
            }

            loop_load_row1:
            for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                
                loop_load_row1_x:
                for(uint32_t x = 0; x < inputWidth; ++x) {

                    #pragma HLS PIPELINE II=1
                    lineBuffer1[iChannel*inputWidth + x] = *(input
                                                        + iChannel*inputHeight*inputWidth
                                                        + (y+1)*inputWidth
                                                        + x);
                }
            }

            loop_load_row2:
            for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                
                loop_load_row2_x:
                for(uint32_t x = 0; x < inputWidth; ++x) {

                    #pragma HLS PIPELINE II=1
                    lineBuffer2[iChannel*inputWidth + x] = *(input
                                                        + iChannel*inputHeight*inputWidth
                                                        + (y+2)*inputWidth
                                                        + x);
                }
            }

            // Task 1: convolution (finally)
            loop_conv_x:
            for(uint32_t x = 0; x < (inputWidth-2); ++x) {

                TFXP acc = 0;

                loop_accumulate_channel:
                for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

                    #pragma HLS PIPELINE II=1

                    loop_accumulate_ky:
                    for (uint32_t ky = 0; ky < convHeight; ++ky) {

                        #pragma HLS UNROLL

                        loop_acc_kx:
                        for (uint32_t kx = 0; kx < convWidth; ++kx) {

                            #pragma HLS UNROLL

                            TFXP pixelValue;
                            if(ky == 0) {
                                pixelValue = lineBuffer0[iChannel*inputWidth + x + kx];
                            } else if(ky == 1) {
                                pixelValue = lineBuffer1[iChannel*inputWidth + x + kx];
                            } else {
                                pixelValue = lineBuffer2[iChannel*inputWidth + x + kx];
                            };

                            acc += FXP_Mult(filterCoeffs[iChannel][ky][kx], pixelValue, DECIMALS);
                        }
                    }
                }

                *(output + iFilter*(inputHeight-2)*(inputWidth-2) + y*(inputWidth-2) + x) = acc;
            }
        }
    }
}
