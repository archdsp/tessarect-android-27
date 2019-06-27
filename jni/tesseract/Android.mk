LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := libtess

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

LOCAL_SRC_FILES := $(wildcard \
  $(LIB_TESSERACT_PATH)/src/api/*.cpp \
  $(LIB_TESSERACT_PATH)/src/arch/*.cpp \
  $(LIB_TESSERACT_PATH)/src/ccmain/*.cpp \
  $(LIB_TESSERACT_PATH)/src/ccstruct/*.cpp \
  $(LIB_TESSERACT_PATH)/src/ccutil/*.cpp \
  $(LIB_TESSERACT_PATH)/src/classify/*.cpp \
  $(LIB_TESSERACT_PATH)/src/cutil/*.cpp \
  $(LIB_TESSERACT_PATH)/src/dict/*.cpp \
  $(LIB_TESSERACT_PATH)/src/lstm/*.cpp \
  $(LIB_TESSERACT_PATH)/src/opencl/*.cpp \
  $(LIB_TESSERACT_PATH)/src/textord/*.cpp \
  $(LIB_TESSERACT_PATH)/src/viewer/*.cpp \
  $(LIB_TESSERACT_PATH)/src/wordrec/*.cpp \
  $(LIB_TESSERACT_PATH)/src/glob/*.c \
  )

$(info $(LOCAL_SRC_FILES))

LOCAL_CPPFLAGS := \
  -DGRAPHICS_DISABLED \
  -DHAVE_CONFIG_H \
  -Wno-deprecated \
  --std=c++17 \
  -fPIE -pie
#  -DUSE_STD_NAMESPACE \
#  -include ctype.h \
#  -include unistd.h \
#  -fpermissive \
#  -Wno-shift-negative-value \
#  -D_GLIBCXX_PERMIT_BACKWARD_HASH

LOCAL_LDLIBS += \
	-llog \
	-ljnigraphics
	# -latomic \

LOCAL_SHARED_LIBRARIES := liblept
LOCAL_PRELINK_MODULE = false

# build 방법 설정
include $(BUILD_SHARED_LIBRARY)
