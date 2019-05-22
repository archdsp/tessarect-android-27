# Tesseract OCR for android

[![Build Status](https://travis-ci.org/tesseract-ocr/tesseract.svg?branch=master)](https://travis-ci.org/tesseract-ocr/tesseract)
[![Build status](https://ci.appveyor.com/api/projects/status/miah0ikfsf0j3819/branch/master?svg=true)](https://ci.appveyor.com/project/zdenop/tesseract/)<br>
[![Coverity Scan Build Status](https://scan.coverity.com/projects/tesseract-ocr/badge.svg)](https://scan.coverity.com/projects/tesseract-ocr)
[![Code Quality: Cpp](https://img.shields.io/lgtm/grade/cpp/g/tesseract-ocr/tesseract.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/tesseract-ocr/tesseract/context:cpp)
[![Total Alerts](https://img.shields.io/lgtm/alerts/g/tesseract-ocr/tesseract.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/tesseract-ocr/tesseract/alerts)<br/>
[![GitHub license](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://raw.githubusercontent.com/tesseract-ocr/tesseract/master/LICENSE)
[![Original repo Downloads](https://img.shields.io/badge/download-all%20releases-brightgreen.svg)](https://github.com/tesseract-ocr/tesseract/releases/)

## About

This package is a fork of **OCR engine** `tesseract-ocr` and tesseract android version `tess-two` repo.
Tesseract 4 adds a new neural net (LSTM) based OCR engine which is focused
on line recognition, but also still supports the legacy Tesseract OCR engine of
Tesseract 3 which works by recognizing character patterns. Compatibility with
Tesseract 3 is enabled by using the Legacy OCR Engine mode (--oem 0).
It also needs traineddata files which support the legacy engine, for example
those from the tessdata repository.

This package contains prebuilted library named libc, liblept, libpngt, linjpgt.
libpngt, libjpgt, liblept (leptonicat library) is built from tess-two repo's com_googlecode_leptonica_android.

libc was built from `GlastoCollider-Android repo` because of containing glob module. This repo's glob module can only used on API >= 28 env,
So in this `tesseract-andoird27` repo, glob module are modified little to uses on API == 27 env.
If you want to compile glob module for API == 27, modify and compile glob.c and glob.h in `GlastoCollider-Android repo`.

Tested ndk-build was downloaded from android studio which targeting api level 27.
ndk-build -v output is as below

>GNU Make 3.81
>Copyright (C) 2006  Free Software Foundation, Inc.
>This is free software; see the source for copying conditions.
>There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>PARTICULAR PURPOSE.
>
>This program built for x86_64-pc-linu


## Compile using ndk-build

Tested ndk-build uses ***GNU Make 3.81***.
move to 'jni' directory, you can see Android.mk and Application.mk.
modified Application.mk if you want to compile other APP_ABI.

Then just type ndk-build


## How to use on Android Studio?
After build, i will generate .so files in libs folder.
copy the whole file into your android studio project's app/src/main/jnilibs/${APP_ABI}/.
In my case, APP_ABI was arm64_v8a.

Describe your prebuilted library on CMakeList.txt

[Example]

```shell
set(PATH_TESSERACT /home/dsparch/Project/Sample/tesseract-android/jni/tesseract)
set(PATH_LIB_TESSERACT ${PATH_PROJECT}/app/src/main/JniLibs/${ANDROID_ABI}/libtess.so)
set(PATH_TESSERACT_SRC ${PATH_TESSERACT}/src)

set(PATH_LEPTONICA /home/dsparch/Project/Sample/tesseract-android/jni/leptonica)
set(PATH_LIB_LEPTONICA ${PATH_PROJECT}/app/src/main/JniLibs/${ANDROID_ABI}/liblept.so)
set(PATH_LEPTONICA_SRC ${PATH_LEPTONICA})

set(PATH_LIB_JPEG ${PATH_PROJECT}/app/src/main/JniLibs/${ANDROID_ABI}/libjpgt.so)
set(PATH_LIB_PNG ${PATH_PROJECT}/app/src/main/JniLibs/${ANDROID_ABI}/libpngt.so)
set(PATH_LIB_CPP_SHARED ${PATH_PROJECT}/app/src/main/JniLibs/${ANDROID_ABI}/libc++_shared.so)
set(PATH_LIB_C_28 ${PATH_PROJECT}/app/src/main/JniLibs/${ANDROID_ABI}/libc.so)

# Tesseract header directory
include_directories(${PATH_TESSERACT_SRC}/api)
include_directories(${PATH_TESSERACT_SRC}/arch)
include_directories(${PATH_TESSERACT_SRC}/ccmain)
include_directories(${PATH_TESSERACT_SRC}/ccstruct)
include_directories(${PATH_TESSERACT_SRC}/ccutil)
include_directories(${PATH_TESSERACT_SRC}/classify)
include_directories(${PATH_TESSERACT_SRC}/cutil)
include_directories(${PATH_TESSERACT_SRC}/dict)
include_directories(${PATH_TESSERACT_SRC}/lstm)
include_directories(${PATH_TESSERACT_SRC}/opencl)
include_directories(${PATH_TESSERACT_SRC}/textord)
include_directories(${PATH_TESSERACT_SRC}/training)
include_directories(${PATH_TESSERACT_SRC}/viewer)
include_directories(${PATH_TESSERACT_SRC}/wordrec)

# Leptonica header directory
include_directories(${PATH_LEPTONICA})
include_directories(${PATH_LEPTONICA_SRC}/src)
include_directories(${PATH_LEPTONICA_SRC}/src/src)

add_library(lib_tesseract SHARED IMPORTED)
set_target_properties(lib_tesseract PROPERTIES IMPORTED_LOCATION ${PATH_LIB_TESSERACT})

add_library(lib_leptonica SHARED IMPORTED)
set_target_properties(lib_leptonica PROPERTIES IMPORTED_LOCATION ${PATH_LIB_LEPTONICA})

add_library(lib_jpeg SHARED IMPORTED)
set_target_properties(lib_jpeg PROPERTIES IMPORTED_LOCATION ${PATH_LIB_JPEG})

add_library(lib_png SHARED IMPORTED)
set_target_properties(lib_png PROPERTIES IMPORTED_LOCATION ${PATH_LIB_PNG})

add_library(lib_cpp_shared SHARED IMPORTED)
set_target_properties(lib_cpp_shared PROPERTIES IMPORTED_LOCATION ${PATH_LIB_CPP_SHARED})

add_library(lib_c_28 SHARED IMPORTED)
set_target_properties(lib_c_28 PROPERTIES IMPORTED_LOCATION ${PATH_LIB_C_28})

target_link_libraries( # Specifies the target library.
        native-lib
        lib_leptonica
        lib_jpeg
        lib_png
        lib_tesseract
        lib_cpp_shared
        lib_c_28

        # Links the target library to the log library
        # included in the NDK.
        ${log-lib})

```

## License

	The original tesseract repository follows Apache License, Version 2.0 so this repository also follows all of
	rules and License of original repository.

**NOTE**: This software depends on other packages that may be licensed under different open source licenses.

Tesseract uses [Leptonica library](http://leptonica.com/) which essentially
uses a [BSD 2-clause license](http://leptonica.com/about-the-license.html).
