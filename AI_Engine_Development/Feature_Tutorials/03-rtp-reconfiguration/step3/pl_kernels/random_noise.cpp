/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include <stdlib.h>
#include <iostream>
#include <hls_stream.h>
#include <complex>

static unsigned long int next = 1;

int my_rand(void) // RAND_MAX assumed to be 32767
{
    next = next * 1103515245 + 12345;
    return (unsigned int)(next/65536) % 32768;
}

void my_srand(unsigned int seed)
{
    next = seed;
}

extern "C" void random_noise(hls::stream<std::complex<short> > & out) {
#pragma HLS INTERFACE axis port=out
#pragma HLS INTERFACE ap_ctrl_none port=return
  std::complex<short>  sample;
  sample.real ( (my_rand() % 256) - 127);
  sample.imag ( (my_rand() % 256) - 127);

  out.write(sample);

}

