LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := liblept

BLACKLIST_SRC_FILES := \
  %endiantest.c \
  %freetype.c \
  %xtractprotos.c

LEPTONICA_SRC_FILES := \
  $(subst $(LOCAL_PATH)/,,$(wildcard $(LIB_LEPTONICA_PATH)/src/src/*.c))

LOCAL_SRC_FILES := \
  $(filter-out $(BLACKLIST_SRC_FILES),$(LEPTONICA_SRC_FILES))

LOCAL_CFLAGS := \
  -DHAVE_CONFIG_H \
  -DANDROID_DEBUG \
  -fPIE -pie

LOCAL_LDLIBS := \
  -lz

LOCAL_C_INCLUDES += \
  $(LOCAL_PATH) \
  $(LOCAL_PATH)/src/src \
  $(LIB_JPEG_PATH) \
  $(LIB_PNG_PATH) \
  $(LIB_TESSERACT_PATH)/src \
  $(ANDROID_UTIL_PATH)
  
LOCAL_LDLIBS += \
  -ljnigraphics \
  -llog \

# common
LOCAL_SHARED_LIBRARIES:= libjpgt libpngt
LOCAL_PRELINK_MODULE:= false
include $(BUILD_SHARED_LIBRARY)
