#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>
#include <inttypes.h>

// Check if need more includes, but CAccelProxy and CConv2DProxy are already included in model.h !!
#include "model.h"
#include "cnn.h"

bool ConvertWeightsToFxP(const uint32_t numLayers, float ** floatWeights, TFXP ** fxpWeights, CConv2DProxy & conv2DHW)
{
  float * pFloat;
  TFXP * pFxp;

  for (uint32_t iLayer = 0; iLayer < numLayers; ++ iLayer) {
    pFloat = floatWeights[iLayer];
    uint32_t layerSize = LayerTypes[iLayer] == CONV ? LayerShapes[iLayer][0] * LayerShapes[iLayer][1] * 3*3 : LayerShapes[iLayer][0] * LayerShapes[iLayer][1];
    // Equivalent to malloc, but we need to allocate the weights in DMA-compatible memory :))
    if ( (fxpWeights[iLayer] = (TFXP*)conv2DHW.AllocDMACompatible(layerSize * sizeof(TFXP))) == NULL ) {
      printf("Error allocating %" PRIu32 " bytes for FxP weights in layer %u\n", (uint32_t)(layerSize*sizeof(TFXP)), iLayer);
      return false;
    }
    pFxp = fxpWeights[iLayer];
    for (uint32_t iFilter = 0; iFilter < LayerShapes[iLayer][1]; ++ iFilter) {
      for (uint32_t iChannel = 0; iChannel < LayerShapes[iLayer][0]; ++ iChannel) {
        if (LayerTypes[iLayer] == CONV) {
          for (uint32_t iWeight = 0; iWeight < 9; ++ iWeight) {
            *pFxp = Float2Fxp(*pFloat, DECIMALS);
            ++ pFxp;
            ++ pFloat;
          }
        } else {
          *pFxp = Float2Fxp(*pFloat, DECIMALS);
          ++ pFxp;
          ++ pFloat;
        }
      }
    }
  }
  return true;
}

void FreeParams(const uint32_t numLayers, void ** params, CConv2DProxy & conv2DHW)
{
  for (uint32_t ii = 0; ii < numLayers; ++ ii) {
    if (params[ii]) {
      conv2DHW.FreeDMACompatible(params[ii]);
      params[ii] = NULL;
    }
  }
}

bool LoadFloatWeights(const uint32_t numLayers, float ** weights)
{
  FILE * input = NULL;

  for (uint32_t iLayer = 0; iLayer < numLayers; ++ iLayer) {
    char title[256];
    snprintf(title, sizeof(title), "model/weights_%u.bin", iLayer);
    input = fopen(title, "rb");
    if (input == NULL) {
      printf("Error opening file [%s]\n", title);
      return false;
    }
    uint32_t layerSize = LayerTypes[iLayer] == CONV ? LayerShapes[iLayer][0] * LayerShapes[iLayer][1] * 3*3 : LayerShapes[iLayer][0] * LayerShapes[iLayer][1];
    if ( (weights[iLayer] = (float*)malloc(layerSize * sizeof(float))) == NULL ) {
      printf("Error allocating %" PRIu32 " bytes to read file [%s]\n", (uint32_t)(layerSize*sizeof(float)), title);
      fclose(input);
      return false;
    }
    if ( fread(weights[iLayer], sizeof(float), layerSize, input) != layerSize ) {
      printf("Error reading %u values from file [%s]\n", layerSize, title);
      fclose(input);
      return false;
    }
    fclose(input);
  }

  return true;
}

bool ConvertBiasesToFxP(const uint32_t numLayers, float ** floatBiases, TFXP ** fxpBiases, CConv2DProxy & conv2DHW)
{
  float * pFloat;
  TFXP * pFxp;

  for (uint32_t iLayer = 0; iLayer < numLayers; ++ iLayer) {
    pFloat = floatBiases[iLayer];
    uint32_t layerSize = LayerShapes[iLayer][1];
    // malloc -> AllocDMACompatible
    if ( (fxpBiases[iLayer] = (TFXP*)conv2DHW.AllocDMACompatible(layerSize * sizeof(TFXP))) == NULL ) {
      printf("Error allocating %" PRIu32 " bytes for FxP biases in layer %u\n", (uint32_t)(layerSize*sizeof(TFXP)), iLayer);
      return false;
    }
    pFxp = fxpBiases[iLayer];
    for (uint32_t iFilter = 0; iFilter < LayerShapes[iLayer][1]; ++ iFilter) {
          *pFxp = Float2Fxp(*pFloat, DECIMALS);
          ++ pFxp;
          ++ pFloat;
    }
  }
  return true;
}

bool LoadFloatBiases(const uint32_t numLayers, float ** biases)
{
  FILE * input = NULL;

  for (uint32_t iLayer = 0; iLayer < numLayers; ++ iLayer) {
    char title[256];
    snprintf(title, sizeof(title), "model/bias_%u.bin", iLayer);
    input = fopen(title, "rb");
    if (input == NULL) {
      printf("Error opening file [%s]\n", title);
      return false;
    }
    uint32_t layerSize = LayerShapes[iLayer][1]; // One bias per output filter.
    if ( (biases[iLayer] = (float*)malloc(layerSize * sizeof(float))) == NULL ) {
      printf("Error allocating %" PRIu32 " bytes to read file [%s]\n", (uint32_t)(layerSize*sizeof(float)), title);
      fclose(input);
      return false;
    }
    if ( fread(biases[iLayer], sizeof(float), layerSize, input) != layerSize ) {
      printf("Error reading %u values from file [%s]\n", layerSize, title);
      fclose(input);
      return false;
    }
    fclose(input);
  }

  return true;
}

bool LoadModelInFxP(TFXP ** fxpWeights, TFXP ** fxpBiases, CConv2DProxy & conv2DHW)
{
  float * floatWeights[NUM_LAYERS];
  float * floatBiases[NUM_LAYERS];

  for (uint32_t ii = 0; ii < NUM_LAYERS; ++ ii) {
    fxpWeights[ii] = NULL;
    floatWeights[ii] = NULL;
    fxpBiases[ii] = NULL;
    floatBiases[ii] = NULL;
  }

  if (!LoadFloatWeights(NUM_LAYERS, floatWeights)) {
    printf("Error reading the float weights.\n");
    FreeParams(NUM_LAYERS, (void**)floatWeights, conv2DHW);
    return false;
  }
  if (!ConvertWeightsToFxP(NUM_LAYERS, floatWeights, fxpWeights, conv2DHW)) {
    printf("Error converting float weights to FxP.\n");
    FreeParams(NUM_LAYERS, (void**)floatWeights, conv2DHW);
    FreeParams(NUM_LAYERS, (void**)fxpWeights, conv2DHW);
    return false;
  }
  FreeParams(NUM_LAYERS, (void**)floatWeights, conv2DHW);

  if (!LoadFloatBiases(NUM_LAYERS, floatBiases)) {
    printf("Error reading the float biases.\n");
    FreeParams(NUM_LAYERS, (void**)floatBiases, conv2DHW);
    FreeParams(NUM_LAYERS, (void**)fxpWeights, conv2DHW);
    return false;
  }
  if (!ConvertBiasesToFxP(NUM_LAYERS, floatBiases, fxpBiases, conv2DHW)) {
    printf("Error converting float biases to FxP.\n");
    FreeParams(NUM_LAYERS, (void**)floatBiases, conv2DHW);
    FreeParams(NUM_LAYERS, (void**)fxpWeights, conv2DHW);
    FreeParams(NUM_LAYERS, (void**)fxpBiases, conv2DHW);
    return false;
  }
  FreeParams(NUM_LAYERS, (void**)floatBiases, conv2DHW);

  return true;
}

bool LoadImageInFxp(const char * fileName, TFXP * inputImageFxp, uint8_t * inputImageRGB, uint32_t inputSize)
{
  FILE * inputImageFile;

  // Load input image and convert to FxP
  inputImageFile = fopen(fileName, "rb");
  if (inputImageFile == NULL) {
    printf("Error opening image [%s]\n", fileName);
    return false;
  }

  if ( fread(inputImageRGB, 1, inputSize, inputImageFile) != inputSize ) {
    printf("Error reading %u bytes from [%s]\n", inputSize, fileName);
    fclose(inputImageFile);
    return false;
  }
  fclose(inputImageFile);

  // Convert image from RGB 8-8-8 pixels to fxp, normalized to [0.0-1.0)
  for (uint32_t ii = 0; ii < inputSize; ++ ii)
    inputImageFxp[ii] = Float2Fxp((inputImageRGB[ii]/255.0), DECIMALS);

  return true;
}

TFXP Inference(TFXP * inputImageFxp, TFXP * buffer0, TFXP * buffer1, TFXP ** fxpWeights, TFXP ** fxpBiases, TTimes & times, CConv2DProxy & conv2DHW)
{
  uint32_t iLayer, size;
  struct timespec start, end;

  /*
  We want to implement the "ping-pong buffers" as explained in the exercise 3 homework statement.
  */

  ///////////////////////////////////////////////////////////////////////////////
  // Layer0: Conv0 + Maxpool 2%
  ///////////////////////////////////////////////////////////////////////////////
  iLayer = 0, size = 256;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  // call to SW convolution:
  // Conv2D(inputImageFxp, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][1], LayerShapes[iLayer][0], size, size);
  // call to HW convolution:
  // inputImageFxp to buffer0
  conv2DHW.Conv2D_HW(inputImageFxp, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][0], LayerShapes[iLayer][1], size, size);
  size -= 2;
  AddBiases(buffer0, fxpBiases[iLayer], LayerShapes[iLayer][1], size, size);
  ReLU(buffer0, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeConv[iLayer] = CalcTimeDiff(end, start);
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  // buffer0 to buffer1 !!!!!!!
  MaxPool(buffer0, buffer1, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeMaxPool[iLayer] = CalcTimeDiff(end, start);
  ++ iLayer;

  ///////////////////////////////////////////////////////////////////////////////
  // Layer1: Conv1 + Maxpool 2%
  ///////////////////////////////////////////////////////////////////////////////
  size = 127;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  // Conv2D(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][1], LayerShapes[iLayer][0], size, size);
  // buffer1 to buffer0
  conv2DHW.Conv2D_HW(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][0], LayerShapes[iLayer][1], size, size);
  size -= 2;
  AddBiases(buffer0, fxpBiases[iLayer], LayerShapes[iLayer][1], size, size);
  ReLU(buffer0, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeConv[iLayer] = CalcTimeDiff(end, start);
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  MaxPool(buffer0, buffer1, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeMaxPool[iLayer] = CalcTimeDiff(end, start);
  ++ iLayer;

  ///////////////////////////////////////////////////////////////////////////////
  // Layer2: Conv2 + Maxpool 2%
  ///////////////////////////////////////////////////////////////////////////////
  size = 62;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  //Conv2D(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][1], LayerShapes[iLayer][0], size, size);
  // buffer1 to buffer0
  conv2DHW.Conv2D_HW(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][0], LayerShapes[iLayer][1], size, size);
  size -= 2;
  AddBiases(buffer0, fxpBiases[iLayer], LayerShapes[iLayer][1], size, size);
  ReLU(buffer0, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeConv[iLayer] = CalcTimeDiff(end, start);
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  MaxPool(buffer0, buffer1, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeMaxPool[iLayer] = CalcTimeDiff(end, start);
  ++ iLayer;

  ///////////////////////////////////////////////////////////////////////////////
  // Layer3: Conv3 + Maxpool 2%
  ///////////////////////////////////////////////////////////////////////////////
  size = 30;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  //Conv2D(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][1], LayerShapes[iLayer][0], size, size);
  // buffer1 to buffer0
  conv2DHW.Conv2D_HW(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][0], LayerShapes[iLayer][1], size, size);
  size -= 2;
  AddBiases(buffer0, fxpBiases[iLayer], LayerShapes[iLayer][1], size, size);
  ReLU(buffer0, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeConv[iLayer] = CalcTimeDiff(end, start);
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  MaxPool(buffer0, buffer1, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeMaxPool[iLayer] = CalcTimeDiff(end, start);
  ++ iLayer;

  ///////////////////////////////////////////////////////////////////////////////
  // Layer4: Conv4 + Maxpool 2%
  ///////////////////////////////////////////////////////////////////////////////
  size = 14;
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  //Conv2D(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][1], LayerShapes[iLayer][0], size, size);
  // buffer1 to buffer0
  conv2DHW.Conv2D_HW(buffer1, buffer0, fxpWeights[iLayer], LayerShapes[iLayer][0], LayerShapes[iLayer][1], size, size);
  size -= 2;
  AddBiases(buffer0, fxpBiases[iLayer], LayerShapes[iLayer][1], size, size);
  ReLU(buffer0, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeConv[iLayer] = CalcTimeDiff(end, start);
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  MaxPool(buffer0, buffer1, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeMaxPool[iLayer] = CalcTimeDiff(end, start);

  ///////////////////////////////////////////////////////////////////////////////
  // Flatten + Dense5 + ReLU 2%
  ///////////////////////////////////////////////////////////////////////////////
  size = 6;
  // Flatten the output for the next dense layer: [row, col, filter]
  // From [64, 6, 6] to [2304]
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  Flatten(buffer1, buffer0, LayerShapes[iLayer][1], size, size);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeFlatten = CalcTimeDiff(end, start);
  ++ iLayer;

  // Output is now 6x6x64 --> 2304. Goes to a fully-connected layer.
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  Dense(buffer0, buffer1, LayerShapes[iLayer][0], LayerShapes[iLayer][1], fxpWeights[iLayer], fxpBiases[iLayer]);
  ReLU(buffer1, 1, LayerShapes[iLayer][1], 1);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeDense[iLayer] = CalcTimeDiff(end, start);
  ++ iLayer;

  // Output is now an array of 512 values. Goes to the final fully-connected layer.
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  Dense(buffer1, buffer0, LayerShapes[iLayer][0], LayerShapes[iLayer][1], fxpWeights[iLayer], fxpBiases[iLayer]);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeDense[iLayer] = CalcTimeDiff(end, start);

  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  Sigmoid(buffer0, 1);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  times.timeSigmoid = CalcTimeDiff(end, start);

  return buffer0[0];
}

uint64_t CalcTimeDiff(const struct timespec & time2, const struct timespec & time1)
{
  return time2.tv_sec == time1.tv_sec ?
    time2.tv_nsec - time1.tv_nsec :
    (time2.tv_sec - time1.tv_sec - 1) * 1e9 + (1e9 - time1.tv_nsec) + time2.tv_nsec;
}
