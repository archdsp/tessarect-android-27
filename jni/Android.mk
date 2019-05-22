LOCAL_PATH := $(call my-dir)
# $(info 현재 디렉토리 위치=$(LOCAL_PATH))

include $(CLEAR_VARS)
LOCAL_MODULE := lept
LOCAL_SRC_FILES := $(wildcard ./libs/prebuilt/liblept.so)
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := jpgt
LOCAL_SRC_FILES := $(wildcard ./libs/prebuilt/libjpgt.so)
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := pngt
LOCAL_SRC_FILES := $(wildcard ./libs/prebuilt/libpngt.so)
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := c
LOCAL_SRC_FILES := $(wildcard ./libs/prebuilt/libc.so)
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libtess
# $(info 로컬모듈=$(LOCAL_MODULE))

# LOCAL_STATIC_LIBRARIES := \
#     base \
#     leptonica-$(APP_ABI)
# $(info LOCAL_STATIC_LIBRARIES=$(LOCAL_STATIC_LIBRARIES))

LOCAL_C_INCLUDES := $(APP_C_INCLUDES)
LOCAL_C_INCLUDES += \
  ./ \
  ./src/api \
  ./src/arch2 \
  ./src/lstm \
  ./src/ccmain \
  ./src/ccstruct \
  ./src/ccutil \
  ./src/classify \
  ./src/cutil \
  ./src/dict \
  ./src/image \
  ./src/textord \
  ./src/third_party \
  ./src/wordrec \
  ./src/opencl \
  ./src/viewer \
  ./com_googlecode_leptonica_android/src/src

# $(info 포함된 헤더=$(LOCAL_C_INCLUDES))

LOCAL_SRC_FILES := $(wildcard ./src/api/*.cpp ./src/arch2/*.cpp ./src/lstm/*.cpp ./src/opencl/*.cpp ./src/ccmain/*.cpp ./src/ccstruct/*.cpp ./src/ccutil/*.cpp ./src/ccutil/*.c ./src/classify/*.cpp ./src/cutil/*.cpp ./src/dict/*.cpp ./src/image/*.cpp ./src/textord/*.cpp ./src/viewer/*.cpp ./src/wordrec/*.cpp)

EXPLICIT_SRC_EXCLUDES := \
  ./src/api/tesseractmain.cpp
#  ./src/api/pdfrenderer.cpp\
#  ./src/api/altorenderer.cpp\
#  ./src/api/hocrrenderer.cpp \

LOCAL_SRC_FILES := $(filter-out $(EXPLICIT_SRC_EXCLUDES), $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(LOCAL_SRC_FILES:$(LOCAL_PATH)/%=%)

LOCAL_LDLIBS := -ldl -llog -ljnigraphics
# LOCAL_CFLAGS := -DANDROID_BUILD -DGRAPHICS_DISABLED 
LOCAL_CFLAGS := \
  -DANDROID_BUILD
  -DGRAPHICS_DISABLED \
  --std=c++11 \
  -DUSE_STD_NAMESPACE \
  -include ctype.h \
  -include unistd.h \
  -fpermissive \
  -Wno-deprecated \
  -Wno-shift-negative-value \
  -D_GLIBCXX_PERMIT_BACKWARD_HAS\

# common
LOCAL_PRELINK_MODULE := false
LOCAL_SHARED_LIBRARIES := liblept libjpgt libpngt libc
LOCAL_DISABLE_FORMAT_STRING_CHECKS := true

include $(BUILD_SHARED_LIBRARY)
