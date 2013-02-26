LOCAL_PATH := $(call my-dir)

LIBPIXMAN_SRC= \
	       pixman/pixman/pixman.c                       \
	       pixman/pixman/pixman-access.c                \
	       pixman/pixman/pixman-access-accessors.c      \
	       pixman/pixman/pixman-arm.c                   \
	       pixman/pixman/pixman-arm-simd.c              \
	       pixman/pixman/pixman-arm-simd-asm.S          \
	       pixman/pixman/pixman-arm-neon.c              \
	       pixman/pixman/pixman-arm-neon-asm.S          \
	       pixman/pixman/pixman-arm-neon-asm-bilinear.S \
	       pixman/pixman/pixman-bits-image.c            \
	       pixman/pixman/pixman-combine32.c             \
	       pixman/pixman/pixman-combine-float.c         \
	       pixman/pixman/pixman-conical-gradient.c      \
	       pixman/pixman/pixman-edge.c                  \
	       pixman/pixman/pixman-edge-accessors.c        \
	       pixman/pixman/pixman-fast-path.c             \
	       pixman/pixman/pixman-general.c               \
	       pixman/pixman/pixman-glyph.c                 \
	       pixman/pixman/pixman-gradient-walker.c       \
	       pixman/pixman/pixman-image.c                 \
	       pixman/pixman/pixman-implementation.c        \
	       pixman/pixman/pixman-linear-gradient.c       \
	       pixman/pixman/pixman-matrix.c                \
	       pixman/pixman/pixman-mips.c                  \
	       pixman/pixman/pixman-noop.c                  \
	       pixman/pixman/pixman-ppc.c                   \
	       pixman/pixman/pixman-radial-gradient.c       \
	       pixman/pixman/pixman-region16.c              \
	       pixman/pixman/pixman-region32.c              \
	       pixman/pixman/pixman-solid-fill.c            \
	       pixman/pixman/pixman-timer.c                 \
	       pixman/pixman/pixman-trap.c                  \
	       pixman/pixman/pixman-utils.c                 \
	       pixman/pixman/pixman-x86.c                   \


LIBPIXMAN_CFLAGS:=-DPIXMAN_NO_TLS -DPACKAGE="android-cairo" -DUSE_ARM_NEON -DUSE_ARM_SIMD -include "limits.h"

include $(CLEAR_VARS)

LOCAL_MODULE    := libpixman
LOCAL_CFLAGS    := -O2 $(LIBPIXMAN_CFLAGS) -Ijni/pixman/pixman -Ijni/pixman-extra
LOCAL_LDFLAGS   := 
LOCAL_SRC_FILES := $(LIBPIXMAN_SRC)
LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_STATIC_LIBRARY)
