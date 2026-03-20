// My contribution:
#include "conv2d.hpp"

inline TFXP FXP_Mult(TFXP a, TFXP b, uint32_t decimalBits = DECIMALS)
{
    //return a*b;
    // We need a wider data type to correctly capture the result of the multiplication.
    TFXP_MULT res = (TFXP_MULT)a * (TFXP_MULT)b;
    res = res >> decimalBits;
    return res;
}

void Conv2D_HW(TFXP *input, TFXP * output, TFXP * coeffs,
      uint32_t numChannels, uint32_t numFilters,
      uint32_t inputWidth, uint32_t inputHeight,
      uint32_t convWidth, uint32_t convHeight)
{
    // My contribution: preprocessor pragmas:
    // We have access to 2 AXI4 buses
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

    // Array partitioning, for now complete, maybe change to cyclic?
    // dim=2 for y, dim=3 for x
    #pragma HLS ARRAY_PARTITION variable=filterCoeffs complete dim=2
    #pragma HLS ARRAY_PARTITION variable=filterCoeffs complete dim=3


    TFXP rowBuffer[MAX_CONV_H][MAX_CHANNELS][MAX_INPUT_WIDTH];

    #pragma HLS ARRAY_PARTITION variable=rowBuffer complete dim=1

    // Outer loop over filters: for each filter, first cache its coefficients,
    // then convolve the full input using those cached coefficients.
    loop_filters : for (uint32_t iFilter = 0; iFilter < numFilters; ++iFilter) {

        // Load this filter's coefficients into the local cache (Task 2)
        loop_load_channels : for (uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
            loop_load_coef_y : for (uint32_t y = 0; y < convHeight; ++y) {
                loop_load_coef_x : for (uint32_t x = 0; x < convWidth; ++x) {
                    #pragma HLS PIPELINE II=1
                    filterCoeffs[iChannel][y][x] = *(coeffs
                                                    + iFilter*numChannels*convHeight*convWidth
                                                    + iChannel*convHeight*convWidth
                                                    + y*convWidth
                                                    + x);
                }
            }
        }

        // Load the first 2 input rows before convolution loops (Task 3)
        loop_load_rows_y : for (uint32_t y = 0; y < convHeight - 1; ++y) { // first 2 rows
            loop_load_rows_x : for (uint32_t x = 0; x < inputWidth; ++x) {
                loop_load_channels : for (uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                    rowBuffer[y][iChannel][x] = *(input+iChannel*inputWidth*inputHeight
                                                + y*inputWidth
                                                + x);
                }
            }
        }

        // Convolve the input with the cached coefficients and write output (Task 3)
        loop_convolve_y : for (uint32_t y = 0; y < (inputHeight - 2); ++y) {
            // Load the next input row before the loops start
            // New row at y + convHeight - 1 (= y + 2)
            uint32_t newRow = y + convHeight - 1;

            // Only need 3 rows for next loops, cycle throûgh the slots
            uint32_t rowSlot = newRow % convHeight;

            loop_load_row_ch : for (uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                loop_load_row_x : for (uint32_t x = 0; x < inputWidth; ++x) {
                    #pragma HLS PIPELINE II=1
                    rowBuffer[rowSlot][iChannel][x] = *(input+iChannel*inputWidth*inputHeight
                                                    + newRow*inputWidth
                                                    + x);
                }
            }

            loop_convolve_x : for (uint32_t x = 0; x < (inputWidth - 2); ++x) {
                TFXP acc = 0;

                loop_acc_channels : for (uint32_t iChannel = 0; iChannel < numChannels; ++iChannel) {
                    loop_acc_y : for (uint32_t cy = 0; cy < convHeight; ++cy) {
                        // @TODO !!!!! Seperate into two loops here
                        loop_acc_x : for (uint32_t cx = 0; cx < convWidth; ++cx) {
                            #pragma HLS PIPELINE II=1
                            TFXP pixelValue, coeffValue;
                            coeffValue = filterCoeffs[iChannel][cy][cx];
                            pixelValue = *(input+iChannel*inputWidth*inputHeight
                                                + (y+cy)*inputWidth
                                                + (x+cx));
                            acc += FXP_Mult(coeffValue, pixelValue, DECIMALS);
                        }
                    }
                }

                // output[iFilter][y][x] = acc
                *(output + iFilter * (inputHeight - 2) * (inputWidth - 2)
                         + y * (inputWidth - 2)
                         + x) = acc;
            }
        }
    } // end loop_filters
}
