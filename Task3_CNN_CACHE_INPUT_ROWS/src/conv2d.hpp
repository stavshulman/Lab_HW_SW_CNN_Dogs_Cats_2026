#ifndef CONV2D_H
#define CONV2D_H

#include <stdint.h>
#include <ap_fixed.h>
#include <ap_int.h>

const uint32_t DECIMALS = 20;
typedef int32_t TFXP;
typedef int64_t TFXP_MULT;

// Max values for pragmas
const uint32_t MAX_CHANNELS = 256;
const uint32_t MAX_CONV_H   = 3;
const uint32_t MAX_CONV_W   = 3;
const uint32_t MAX_INPUT_WIDTH  = 2306; // worst case seen in model.h for input width

// Check if convHeight = 3 is correct in header/cpp file
void Conv2D_HW(TFXP *input, TFXP * output, TFXP * coeffs,
      uint32_t numChannels, uint32_t numFilters,
      uint32_t inputWidth, uint32_t inputHeight,
      uint32_t convWidth = 3, uint32_t convHeight = 3);

#endif // CONV2D_H
