APP_ABI := arm64-v8a #x86_64
APP_CFLAGS += -Werror -DHASH_NAMESPACE=__gnu_cxx
APP_PLATFORM := android-27
APP_STL := c++_shared
NDK_TOOLCHAIN_VERSION := clang
