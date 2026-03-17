#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <inttypes.h>

#include "model.h"
// following includes already in model.h
// #include "CAccelProxy.hpp"
// #include "CAccel2DProxy.hpp"

const uint32_t INPUT_SIZE = (256*256*3);

// weights and biases need to be dma compatible :)))
TFXP * weights[NUM_LAYERS];
TFXP * biases[NUM_LAYERS];
TTimes times;

uint8_t inputImage[INPUT_SIZE];   // RGB pixel data separated in planes.
TFXP * inputImageFxp;  // RGB planar data, converted to [0, 1] in FxP, changed to pointer to be allocated in DMA memory.

// Ping pong buffers for intermediate results in layers
TFXP * buffer0, * buffer1;

void InitTimes(TTimes & times);
void PrintTimes(TTimes & times, uint32_t numLayers);

int main(int argc, char ** argv)
{
  CConv2DProxy convolver(true); // Activate logging. Deactivate if too verbose

  if (argc != 2) {
    printf("Usage: cnnSolver image.rgba.planar\n");
    return -1;
  }

  if (convolver.Open(CONV2D_HW_ADDR) != CConv2DProxy::OK) {
    printf("Error opening Conv2D HW accelerator.\n");
    return -1;
  }

  // Allocate image and buffers using DMA
  inputImageFxp = (TFXP*)convolver.AllocDMACompatible(INPUT_SIZE * sizeof(TFXP));
  buffer0 = (TFXP*)convolver.AllocDMACompatible(4129024 * sizeof(TFXP));
  buffer1 = (TFXP*)convolver.AllocDMACompatible(1032256 * sizeof(TFXP));

  // Check allocations
  if (inputImageFxp == NULL || buffer0 == NULL || buffer1 == NULL) {
    printf("Error allocating DMA buffers.\n");
    if (inputImageFxp) convolver.FreeDMACompatible(inputImageFxp);
    if (buffer0) convolver.FreeDMACompatible(buffer0);
    if (buffer1) convolver.FreeDMACompatible(buffer1);
    return -1;
  }

  if (!LoadModelInFxP(weights, biases)) {
    printf("Error loading the CNN model and converting to FxP!\n");
    convolver.FreeDMACompatible(inputImageFxp);
    convolver.FreeDMACompatible(buffer0);
    convolver.FreeDMACompatible(buffer1);
    return -1;
  }

  if (!LoadImageInFxp(argv[1], inputImageFxp, inputImage, INPUT_SIZE)) {
    printf("Error loading the image file.\n");
    FreeParams(NUM_LAYERS, (void**)weights, convolver);
    FreeParams(NUM_LAYERS, (void**)biases, convolver);
    convolver.FreeDMACompatible(inputImageFxp);
    convolver.FreeDMACompatible(buffer0);
    convolver.FreeDMACompatible(buffer1);
    return -1;
  }

  InitTimes(times);
  // My contribution: check if call to Inference() is correct
  TFXP finalPrediction = Inference(inputImageFxp, buffer0, buffer1, weights, biases, times, convolver);
  printf("OUTPUT: %0.8lf --> %s\n", Fxp2Float(finalPrediction, DECIMALS),
    Fxp2Float(finalPrediction) < 0.5 ? "CAT" : "DOG");
  PrintTimes(times, NUM_LAYERS);

  FreeParams(NUM_LAYERS, (void**)weights, convolver);
  FreeParams(NUM_LAYERS, (void**)biases, convolver);

  // Free DMA image and buffers
  convolver.FreeDMACompatible(inputImageFxp);
  convolver.FreeDMACompatible(buffer0);
  convolver.FreeDMACompatible(buffer1);

  return Fxp2Float(finalPrediction) < 0.5 ? 0 : 1;;
}


void InitTimes(TTimes & times)
{
  for (uint32_t ii = 0; ii < NUM_LAYERS; ++ ii) {
    times.timeConv[ii] = 0;
    times.timeMaxPool[ii] = 0;
    times.timeDense[ii] = 0;
  }
  times.timeFlatten = 0;
  times.timeSigmoid = 0;
}

void PrintTimes(TTimes & times, uint32_t numLayers)
{
  uint64_t accConv = 0, accMaxPool = 0, accDense = 0;
  double totalTime;

  for (uint32_t ii = 0; ii < numLayers; ++ ii) {
    if (times.timeConv[ii] != 0) {
      printf("Conv %u --> %" PRIu64 " ns (%0.3lf s)\n", ii, times.timeConv[ii], times.timeConv[ii]/1e9);
      accConv += times.timeConv[ii];
    }
  }

  for (uint32_t ii = 0; ii < numLayers; ++ ii) {
    if (times.timeMaxPool[ii] != 0) {
      printf("MaxPool %u --> %" PRIu64 " ns (%0.3lf s)\n", ii, times.timeMaxPool[ii], times.timeMaxPool[ii]/1e9);
      accMaxPool += times.timeMaxPool[ii];
    }
  }

  for (uint32_t ii = 0; ii < numLayers; ++ ii) {
    if (times.timeDense[ii] != 0) {
      printf("Dense %u --> %" PRIu64 " ns (%0.3lf s)\n", ii, times.timeDense[ii], times.timeDense[ii]/1e9);
      accDense += times.timeDense[ii];
    }
  }

  totalTime = accConv + accMaxPool + accDense + times.timeFlatten + times.timeSigmoid;
  printf("Total Conv time: %" PRIu64 " ns (%0.3lf s) %0.1lf %%\n", accConv, accConv/1e9, (accConv/totalTime)*100);
  printf("Total MaxPool time: %" PRIu64 " ns (%0.3lf s) %0.1lf %%\n", accMaxPool, accMaxPool/1e9, (accMaxPool/totalTime)*100);
  printf("Total Dense time: %" PRIu64 " ns (%0.3lf s) %0.1lf %%\n", accDense, accDense/1e9, (accDense/totalTime)*100);
  printf("Total Flatten time: %" PRIu64 " ns (%0.3lf s) %0.1lf %%\n", times.timeFlatten, times.timeFlatten/1e9, (times.timeFlatten/totalTime)*100);
  printf("Total Sigmoid time: %" PRIu64 " ns (%0.3lf s) %0.1lf %%\n", times.timeSigmoid, times.timeSigmoid/1e9, (times.timeSigmoid/totalTime)*100);

  printf("Total time: %" PRIu64 " ns (%0.3lf s) %0.1lf %%\n", (uint64_t)totalTime, totalTime/1e9, (totalTime/totalTime)*100); // :-)







}

