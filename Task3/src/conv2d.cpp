#include "conv2d.hpp"

inline TFXP FXP_Mult(TFXP a, TFXP b, uint32_t decimalBits = DECIMALS) {
    TFXP_MULT res = (TFXP_MULT)a * (TFXP_MULT)b;
    res = res >> decimalBits;
    return res;
}

void Conv2D_HW(TFXP *input, TFXP *output, TFXP *coeffs,
               uint32_t numChannels, uint32_t numFilters,
               uint32_t inputWidth, uint32_t inputHeight,
               uint32_t convWidth, uint32_t convHeight) {

    #pragma HLS INTERFACE m_axi port=input  offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=output offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=coeffs offset=slave bundle=gmem1

    #pragma HLS INTERFACE s_axilite port=numFilters
    #pragma HLS INTERFACE s_axilite port=numChannels
    #pragma HLS INTERFACE s_axilite port=inputWidth
    #pragma HLS INTERFACE s_axilite port=inputHeight
    #pragma HLS INTERFACE s_axilite port=convWidth
    #pragma HLS INTERFACE s_axilite port=convHeight
    #pragma HLS INTERFACE s_axilite port=return

    TFXP filterCoeffs[MAX_CHANNELS][MAX_CONV_W][MAX_CONV_H];

    // Too big, need to comment
    // TFXP lineBuffers[3][MAX_CHANNELS][MAX_INPUT_W];
    // 3 different line buffers for each Row, with biggest possible input seen in CNN

    TFXP lineBuffer0[127*32];
    TFXP lineBuffer1[127*32];
    TFXP lineBuffer2[127*32];

    #pragma HLS ARRAY_PARTITION variable=filterCoeffs complete dim=2
    #pragma HLS ARRAY_PARTITION variable=filterCoeffs complete dim=3

    // Maybe change complete -> cyclic
    #pragma HLS ARRAY_PARTITION variable=lineBuffer0 cyclic factor=4
    #pragma HLS ARRAY_PARTITION variable=lineBuffer1 cyclic factor=4
    #pragma HLS ARRAY_PARTITION variable=lineBuffer2 cyclic factor=4

    loop_filters: for(uint32_t iFilter = 0; iFilter < numFilters; ++iFilter) {
        // Need to add TRICOUNT for Vitis HLS sim
        #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_NUM_FILTERS

        // Load buffers
        load_channels_buff: for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
            #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS

            load_cols_buff: for(uint32_t cols = 0; cols < inputWidth; ++cols) {
                #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_INPUT_W
                #pragma HLS PIPELINE II=1

                // loading rows -> lineBuffer
                lineBuffer0[iChannel*inputWidth + cols] = *(input
                                                        + iChannel*inputWidth*inputHeight
                                                        + 0*inputWidth
                                                        + cols);
                lineBuffer1[iChannel*inputWidth + cols] = *(input
                                                        + iChannel*inputWidth*inputHeight
                                                        + 1*inputWidth
                                                        + cols);
                lineBuffer2[iChannel*inputWidth + cols] = *(input
                                                        + iChannel*inputWidth*inputHeight
                                                        + 2*inputWidth
                                                        + cols);
            }
        } // done loading line buffers

        // loading filter coeffs for caching (task 2)
        load_channels_filt: for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
            #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS

            load_rows_filt: for(uint32_t y = 0; y < convHeight; ++y) {
                // convWidth always 3
                #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_H max=MAX_CONV_H

                load_cols_filt: for(uint32_t x = 0; x < convWidth; ++x) {
                    #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_W max=MAX_CONV_W
                    #pragma HLS PIPELINE II=1

                    // pay attention to loop order !!!!
                    filterCoeffs[iChannel][y][x] = *(coeffs
                                                        + iFilter*numChannels*convHeight*convWidth
                                                        + iChannel*convHeight*convWidth
                                                        + y*convWidth
                                                        + x);
                }
            }
        } // done loading filter coeffs, matches task2

        // beginning of convolution (finally)
        loop_height: for(uint32_t y = 0; y < (inputHeight-2); ++y) {
            // max = 256-2
            #pragma HLS LOOP_TRIPCOUNT min=1 max=254

            loop_width: for(uint32_t x = 0; x < (inputWidth-2); ++x) {
                #pragma HLS LOOP_TRIPCOUNT min=1 max=254

                TFXP acc = 0;

                loop_channel: for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                    #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS

                    loop_acc: for(uint32_t cx = 0; cx < convWidth; ++cx) {
                        #pragma HLS LOOP_TRIPCOUNT min=MAX_CONV_W max=MAX_CONV_W
                        #pragma HLS PIPELINE II=1

                        acc += FXP_Mult(filterCoeffs[iChannel][0][cx], lineBuffer0[iChannel*inputWidth + x + cx])
                            + FXP_Mult(filterCoeffs[iChannel][1][cx], lineBuffer1[iChannel*inputWidth + x + cx])
                            + FXP_Mult(filterCoeffs[iChannel][2][cx], lineBuffer2[iChannel*inputWidth + x + cx]);
                    }
                } // done looping over the numChannels

                *(output + iFilter*(inputHeight-2)*(inputWidth-2) + y*(inputWidth-2) + x) = acc;
            }

            // update lineBuffers
            loop_width_update: for(uint32_t x = 0; x < inputWidth; ++x) {
                #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_INPUT_W
                #pragma HLS PIPELINE II=1

                loop_channel_update: for(uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                    #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_CHANNELS

                    lineBuffer0[iChannel*inputWidth + x] = lineBuffer1[iChannel*inputWidth + x];
                    lineBuffer1[iChannel*inputWidth + x] = lineBuffer2[iChannel*inputWidth + x];

                    if(y <= (inputHeight-2)) {
                        lineBuffer2[iChannel*inputWidth + x] = *(input
                                                            + iChannel*inputWidth*inputHeight
                                                            + (y+3)*inputWidth
                                                            + x);
                    }
                }
            }
        }
    }
}
