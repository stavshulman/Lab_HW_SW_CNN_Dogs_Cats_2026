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

    #pragma HLS ARRAY_PARTITION variable=lineBuffer0 cyclic factor=4 dim=1
    #pragma HLS ARRAY_PARTITION variable=lineBuffer1 cyclic factor=4 dim=1
    #pragma HLS ARRAY_PARTITION variable=lineBuffer2 cyclic factor=4 dim=1

    // Constants to be used in loops:
    uint32_t outputWidth = inputWidth - 2;
    uint32_t outputHeight = inputHeight - 2;

    loop_filters: 
    for(uint32_t iFilter = 0; iFilter < numFilters; ++iFilter) {

        #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_NUM_FILTERS

        // Task 2: load filter coeffs into buffer
        loop_load_coeffs_channel: 
        for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

            #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS

            loop_load_coeffs_y: 
            for(uint32_t cy = 0; cy < convHeight; ++cy) {

                #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_H max=MAX_CONV_H

                loop_load_coef_x: 
                for(uint32_t cx = 0; cx < convWidth; ++cx) {

                    #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_W max=MAX_CONV_W
                    #pragma HLS PIPELINE II=1

                    filterCoeffs[iChannel][cy][cx] = *(coeffs
                                                    + iFilter*numChannels*convHeight*convWidth
                                                    + iChannel*convHeight*convWidth
                                                    + cy*convWidth
                                                    + cx);
                }
            }
        }

        int32_t lineOffset = iFilter*outputHeight*outputWidth;

        // Task 3: load input rows, and then convolve
        loop_load_input_rows:
        for(uint32_t y = 0; y < outputHeight; ++y) {

            // 256 - 2
            #pragma HLS LOOP_TRIPCOUNT min=1 max=254

            loop_load_row0:
            for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

                #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS
                
                loop_load_row0_x:
                for(uint32_t x = 0; x < inputWidth; ++x) {

                    #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_INPUT_W
                    #pragma HLS PIPELINE II=1

                    lineBuffer0[iChannel*inputWidth + x] = *(input
                                                        + iChannel*inputHeight*inputWidth
                                                        + (y+0)*inputWidth
                                                        + x);
                }
            }

            loop_load_row1:
            for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

                #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS
                
                loop_load_row1_x:
                for(uint32_t x = 0; x < inputWidth; ++x) {

                    #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_INPUT_W
                    #pragma HLS PIPELINE II=1

                    lineBuffer1[iChannel*inputWidth + x] = *(input
                                                        + iChannel*inputHeight*inputWidth
                                                        + (y+1)*inputWidth
                                                        + x);
                }
            }

            loop_load_row2:
            for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

                #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS
                
                loop_load_row2_x:
                for(uint32_t x = 0; x < inputWidth; ++x) {

                    #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_INPUT_W
                    #pragma HLS PIPELINE II=1

                    lineBuffer2[iChannel*inputWidth + x] = *(input
                                                        + iChannel*inputHeight*inputWidth
                                                        + (y+2)*inputWidth
                                                        + x);
                }
            }

            // Task 1: convolution (finally)
            loop_conv_x:
            for(uint32_t x = 0; x < outputWidth; ++x) {

                // 256 - 2
                #pragma HLS LOOP_TRIPCOUNT min=1 max=254
                #pragma HLS PIPELINE II=1

                TFXP acc = 0;

                // base to accumulate conv, w/ base = iChannel*inputWidth
                uint32_t base = 0;

                loop_accumulate_channel:
                for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {

                    #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS

                    loop_accumulate_ky:
                    for (uint32_t ky = 0; ky < convHeight; ++ky) {

                        #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_H max=MAX_CONV_H
                        #pragma HLS UNROLL

                        loop_acc_kx:
                        for (uint32_t kx = 0; kx < convWidth; ++kx) {

                            #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_W max=MAX_CONV_W
                            #pragma HLS UNROLL

                            TFXP pixelValue;
                            uint32_t indexBuff = base + x + kx;
                            if(ky == 0) {
                                pixelValue = lineBuffer0[indexBuff];
                            } else if(ky == 1) {
                                pixelValue = lineBuffer1[indexBuff];
                            } else {
                                pixelValue = lineBuffer2[indexBuff];
                            };

                            acc += FXP_Mult(filterCoeffs[iChannel][ky][kx], pixelValue, DECIMALS);
                        }
                    }
                    base += inputWidth;
                }

                *(output + lineOffset + x) = acc;
            }

            // loop over y like multiplication:
            lineOffset += outputWidth;
        }
    }
}
