# Include common.mk for building google3 native code.
# DEPOT_PATH := $(firstword $(subst /google3, ,$(abspath $(call my-dir))))
# ifneq ($(wildcard $(DEPOT_PATH)/google3/mobile/build/common.mk),)
#   include $(DEPOT_PATH)/google3/mobile/build/common.mk
# else
#   include $(DEPOT_PATH)/READONLY/google3/mobile/build/common.mk
# endif

# Specify the hash namespace that we're using, based on the APP_STL we're using.
APP_ABI := arm64-v8a
APP_CFLAGS += -Werror -DHASH_NAMESPACE=__gnu_cxx
APP_PLATFORM := android-27
APP_STL := c++_shared
NDK_TOOLCHAIN_VERSION := clang
