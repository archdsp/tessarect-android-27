LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := test

LOCAL_SRC_FILES := main.cpp
LOCAL_C_INCLUDES += \
  $(LIB_TESSERACT_PATH)/ \
  $(LIB_TESSERACT_PATH)/src/ \
  $(LIB_TESSERACT_PATH)/src/api \
  $(LIB_TESSERACT_PATH)/src/arch \
  $(LIB_TESSERACT_PATH)/src/ccmain \
  $(LIB_TESSERACT_PATH)/src/ccstruct \
  $(LIB_TESSERACT_PATH)/src/ccutil \
  $(LIB_TESSERACT_PATH)/src/classify \
  $(LIB_TESSERACT_PATH)/src/cutil \
  $(LIB_TESSERACT_PATH)/src/dict \
  $(LIB_TESSERACT_PATH)/src/lstm \
  $(LIB_TESSERACT_PATH)/src/opencl \
  $(LIB_TESSERACT_PATH)/src/textord \
  $(LIB_TESSERACT_PATH)/src/viewer \
  $(LIB_TESSERACT_PATH)/src/wordrec \
  $(LIB_TESSERACT_PATH)/src/glob \
  $(LIB_LEPTONICA_PATH)/src/src

LOCAL_CFLAGS += -fPIE -pie
LOCAL_SHARED_LIBRARIES := liblept libtess
LOCAL_PRELINK_MODULE = false

# build 방법 설정
include $(BUILD_EXECUTABLE)

