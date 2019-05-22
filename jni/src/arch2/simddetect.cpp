///////////////////////////////////////////////////////////////////////
// File:        simddetect.cpp
// Description: Architecture detector.
// Author:      Stefan Weil (based on code from Ray Smith)
//
// (C) Copyright 2014, Google Inc.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
///////////////////////////////////////////////////////////////////////

#include "simddetect.h"
#include "dotproduct.h"
#include "intsimdmatrix.h"   // for IntSimdMatrix
#include "params.h"   // for STRING_VAR
#include "tprintf.h"  // for tprintf

namespace tesseract {

// Computes and returns the dot product of the two n-vectors u and v.
// Note: because the order of addition is different among the different dot
// product functions, the results can (and do) vary slightly (although they
// agree to within about 4e-15). This produces different results when running
// training, despite all random inputs being precisely equal.
// To get consistent results, use just one of these dot product functions.
// On a test multi-layer network, serial is 57% slower than SSE, and AVX
// is about 8% faster than SSE. This suggests that the time is memory
// bandwidth constrained and could benefit from holding the reused vector
// in AVX registers.
DotProductFunction DotProduct;

static STRING_VAR(dotproduct, "auto",
                  "Function used for calculation of dot product");

SIMDDetect SIMDDetect::detector;

// Computes and returns the dot product of the two n-vectors u and v.
static double DotProductGeneric(const double* u, const double* v, int n) {
  double total = 0.0;
  for (int k = 0; k < n; ++k) total += u[k] * v[k];
  return total;
}

static void SetDotProduct(DotProductFunction f, const IntSimdMatrix* m = nullptr) {
  DotProduct = f;
  IntSimdMatrix::intSimdMatrix = m;
}

// Constructor.
// Tests the architecture in a system-dependent way to detect AVX, SSE and
// any other available SIMD equipment.
// __GNUC__ is also defined by compilers that include GNU extensions such as
// clang.
SIMDDetect::SIMDDetect() {
  // The fallback is a generic dot product calculation.
  SetDotProduct(DotProductGeneric);

#if defined(HAS_CPUID)
#if defined(__GNUC__)
  unsigned int eax, ebx, ecx, edx;
  if (__get_cpuid(1, &eax, &ebx, &ecx, &edx) != 0) {
    // Note that these tests all use hex because the older compilers don't have
    // the newer flags.
  }
#else
#error "I don't know how to test for SIMD with this compiler"
#endif // __GNUC__
#endif // HAS_CPUID

  // Select code for calculation of dot product based on autodetection.
  if (false) {
    // This is a dummy to support conditional compilation.
  }
}

void SIMDDetect::Update() {
  // Select code for calculation of dot product based on the
  // value of the config variable if that value is not empty.
  const char* dotproduct_method = "generic";
  if (!strcmp(dotproduct.string(), "auto")) {
    // Automatic detection. Nothing to be done.
  } else if (!strcmp(dotproduct.string(), "generic")) {
    // Generic code selected by config variable.
    SetDotProduct(DotProductGeneric);
    dotproduct_method = "generic";
  } else if (!strcmp(dotproduct.string(), "native")) {
    // Native optimized code selected by config variable.
    SetDotProduct(DotProductNative);
    dotproduct_method = "native";
  } else {
    // Unsupported value of config variable.
    tprintf("Warning, ignoring unsupported config variable value: dotproduct=%s\n",
            dotproduct.string());
    tprintf("Support values for dotproduct: auto generic native.\n");
  }

  dotproduct.set_value(dotproduct_method);
}

}  // namespace tesseract
