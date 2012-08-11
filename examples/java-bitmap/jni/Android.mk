LOCAL_PATH := $(call my-dir)

include jni/pixman.mk
include jni/cairo.mk
include $(CLEAR_VARS)

LOCAL_MODULE    := java-bitmap
LOCAL_CFLAGS    := -O2 --std=c99 -I. -Ijni/pixman/pixman -Ijni/cairo/src -Ijni/cairo-extra -Ijni/pixman-extra -Wno-missing-field-initializers
LOCAL_LDLIBS    := -lm -llog -ljnigraphics
LOCAL_SRC_FILES := java-bitmap.c
LOCAL_STATIC_LIBRARIES := libcairo libpixman cpufeatures

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/cpufeatures)
