#USE_ARM_SIMD:=1
#USE_ARM_NEON:=1

LOCAL_PATH := $(call my-dir)

LIBPIXMAN_SRC= \
	       pixman/pixman/pixman-access.c           \
	       pixman/pixman/pixman-access-accessors.c \
	       pixman/pixman/pixman-cpu.c              \
	       pixman/pixman/pixman-gradient-walker.c  \
	       pixman/pixman/pixman-region16.c         \
	       pixman/pixman/pixman-region32.c         \
	       pixman/pixman/pixman-image.c            \
	       pixman/pixman/pixman-implementation.c   \
	       pixman/pixman/pixman-general.c          \
	       pixman/pixman/pixman.c                  \
	       pixman/pixman/pixman-fast-path.c        \
	       pixman/pixman/pixman-solid-fill.c       \
	       pixman/pixman/pixman-conical-gradient.c \
	       pixman/pixman/pixman-linear-gradient.c  \
	       pixman/pixman/pixman-radial-gradient.c  \
	       pixman/pixman/pixman-bits-image.c       \
	       pixman/pixman/pixman-utils.c            \
	       pixman/pixman/pixman-edge.c             \
	       pixman/pixman/pixman-edge-accessors.c   \
	       pixman/pixman/pixman-trap.c             \
	       pixman/pixman/pixman-timer.c            \
	       pixman/pixman/pixman-matrix.c           \
	       pixman-extra/pixman-combine32.c         \
	       pixman-extra/pixman-combine64.c         \



LIBPIXMAN_CFLAGS:=-D_USE_MATH_DEFINES -DPIXMAN_NO_TLS -DPACKAGE="android-cairo"


ifdef USE_ARM_SIMD
    LIBPIXMAN_SRC += pixman/pixman/pixman-arm-simd.c
    LIBPIXMAN_SRC += pixman/pixman/pixman-arm-simd-asm.S
    LIBPIXMAN_CFLAGS += -DUSE_ARM_SIMD
endif

ifdef USE_ARM_NEON
    LIBPIXMAN_SRC += pixman/pixman/pixman-arm-neon.c
    LIBPIXMAN_SRC += pixman/pixman/pixman-arm-neon-asm.S
    LIBPIXMAN_CFLAGS += -mfpu=neon -DUSE_ARM_NEON
endif


include $(CLEAR_VARS)

LOCAL_MODULE    := libpixman
LOCAL_CFLAGS    := -O2 $(LIBPIXMAN_CFLAGS) -Ijni/pixman/pixman -Ijni/pixman-extra -Wno-missing-field-initializers
LOCAL_LDFLAGS   := 
LOCAL_SRC_FILES := $(LIBPIXMAN_SRC)

include $(BUILD_STATIC_LIBRARY)
