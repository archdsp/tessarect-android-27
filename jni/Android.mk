# build all Android.mk files in the subdirs
ROOT_PATH:= $(call my-dir)
NDK_MODULE_PATH := $(ROOT_PATH)
LIB_TESSERACT_PATH := $(ROOT_PATH)/tesseract
LIB_LEPTONICA_PATH := $(ROOT_PATH)/leptonica
LIB_JPEG_PATH := $(ROOT_PATH)/jpeg
LIB_PNG_PATH := $(ROOT_PATH)/png
include $(call all-subdir-makefiles)
