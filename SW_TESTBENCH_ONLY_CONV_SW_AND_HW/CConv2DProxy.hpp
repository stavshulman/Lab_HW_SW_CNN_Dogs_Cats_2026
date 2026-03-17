#ifndef CCONV2D_HPP
#define CCONV2D_HPP

// My contribution: important defines:
#define CONV2D_HW_ADDR 0x40000000
#define MAP_SIZE 0x1000

class CConv2DProxy : public CAccelProxy {
  protected:
    // Structure that mimics the layout of the peripheral registers.
    // Vitis HLS skips some addresses in the register file. We introduce
    // padding fields to create the right mapping to registers with our structure,
    // My contribution:
    struct TRegs {
      uint32_t control; // 0x00
      uint32_t gier, ier, isr; // 0x04, 0x08, 0x0C

      // My contribution: add the rest of the registers as seen from Vitis HLS
      uint32_t input_r; // 0x10
      uint32_t padding0; // 0x14
      uint32_t padding0b; // 0x18 (reserved)

      uint32_t output_r; // 0x1C
      uint32_t padding1; // 0x20
      uint32_t padding1b; // 0x24 (reserved)

      uint32_t coeffs; // 0x28 (filters[31:0])
      uint32_t padding2; // 0x2c (filters[63:32])
      uint32_t padding2b; // 0x30 (reserved)

      uint32_t numChannels; // 0x34
      uint32_t padding3; // 0x38 (reserved)
      uint32_t numFilters; // 0x3c
      uint32_t padding4; // 0x40 (reserved)
      uint32_t inputWidth; // 0x44
      uint32_t padding5; // 0x48 (reserved)
      uint32_t inputHeight; // 0x4c
      uint32_t padding6; // 0x50 (reserved)
      uint32_t convWidth; // 0x54
      uint32_t padding7; // 0x58 (reserved)
      uint32_t convHeight; // 0x5c
    };

  public:
    CConv2DProxy(bool Logging = false)
      : CAccelProxy(Logging) {}

    ~CConv2DProxy() {}

    uint32_t Conv2D_HW(void *input, void * output, void * coeffs,
      uint32_t numChannels, uint32_t numFilters,
      uint32_t inputWidth, uint32_t inputHeight,
      uint32_t convWidth = 3, uint32_t convHeight = 3);
};

#endif  // CCONV2D_HPP

