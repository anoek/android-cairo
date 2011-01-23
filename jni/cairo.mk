LIBCAIRO_SRC = \
	       cairo/src/cairo-analysis-surface.c            \
	       cairo/src/cairo-arc.c                         \
	       cairo/src/cairo-array.c                       \
	       cairo/src/cairo-atomic.c                      \
	       cairo/src/cairo-base64-stream.c               \
	       cairo/src/cairo-bentley-ottmann.c             \
	       cairo/src/cairo-bentley-ottmann-rectangular.c \
	       cairo/src/cairo-bentley-ottmann-rectilinear.c \
	       cairo/src/cairo-boxes.c                       \
	       cairo/src/cairo.c                             \
	       cairo/src/cairo-cache.c                       \
	       cairo/src/cairo-clip.c                        \
	       cairo/src/cairo-color.c                       \
	       cairo/src/cairo-composite-rectangles.c        \
	       cairo/src/cairo-debug.c                       \
	       cairo/src/cairo-deflate-stream.c              \
	       cairo/src/cairo-device.c                      \
	       cairo/src/cairo-fixed.c                       \
	       cairo/src/cairo-font-face.c                   \
	       cairo/src/cairo-font-face-twin.c              \
	       cairo/src/cairo-font-face-twin-data.c         \
	       cairo/src/cairo-font-options.c                \
	       cairo/src/cairo-freelist.c                    \
	       cairo/src/cairo-mesh-pattern-rasterizer.c     \
	       cairo/src/cairo-gstate.c                      \
	       cairo/src/cairo-hash.c                        \
	       cairo/src/cairo-hull.c                        \
	       cairo/src/cairo-image-info.c                  \
	       cairo/src/cairo-image-surface.c               \
	       cairo/src/cairo-lzw.c                         \
	       cairo/src/cairo-matrix.c                      \
	       cairo/src/cairo-misc.c                        \
	       cairo/src/cairo-mutex.c                       \
	       cairo/src/cairo-observer.c                    \
	       cairo/src/cairo-output-stream.c               \
	       cairo/src/cairo-paginated-surface.c           \
	       cairo/src/cairo-path-bounds.c                 \
	       cairo/src/cairo-path.c                        \
	       cairo/src/cairo-path-fill.c                   \
	       cairo/src/cairo-path-fixed.c                  \
	       cairo/src/cairo-path-in-fill.c                \
	       cairo/src/cairo-path-stroke.c                 \
	       cairo/src/cairo-pattern.c                     \
	       cairo/src/cairo-pen.c                         \
	       cairo/src/cairo-polygon.c                     \
	       cairo/src/cairo-recording-surface.c           \
	       cairo/src/cairo-rectangle.c                   \
	       cairo/src/cairo-rectangular-scan-converter.c  \
	       cairo/src/cairo-region.c                      \
	       cairo/src/cairo-scaled-font.c                 \
	       cairo/src/cairo-scaled-font-subsets.c         \
	       cairo/src/cairo-slope.c                       \
	       cairo/src/cairo-spans.c                       \
	       cairo/src/cairo-spline.c                      \
	       cairo/src/cairo-stroke-style.c                \
	       cairo/src/cairo-surface.c                     \
	       cairo/src/cairo-surface-clipper.c             \
	       cairo/src/cairo-surface-fallback.c            \
	       cairo/src/cairo-surface-snapshot.c            \
	       cairo/src/cairo-surface-wrapper.c             \
	       cairo/src/cairo-tee-surface.c                 \
	       cairo/src/cairo-tor-scan-converter.c          \
	       cairo/src/cairo-toy-font-face.c               \
	       cairo/src/cairo-traps.c                       \
	       cairo/src/cairo-unicode.c                     \
	       cairo/src/cairo-user-font.c                   \
	       cairo/src/cairo-version.c                     \
	       cairo/src/cairo-wideint.c


LIBCAIRO_CFLAGS:=                                                   \
    -DPACKAGE_VERSION="\"android-cairo\""                           \
    -DPACKAGE_BUGREPORT="\"http://github.com/anoek/android-cairo\"" \
    -DCAIRO_NO_MUTEX=1                                              \
    -DHAVE_STDINT_H


include $(CLEAR_VARS)

LOCAL_MODULE    := libcairo
LOCAL_CFLAGS    := -O2 $(LIBCAIRO_CFLAGS) -Ijni/pixman/pixman -Ijni/cairo/src -Ijni/cairo-extra -Ijni/pixman-extra -Wno-missing-field-initializers
LOCAL_LDFLAGS   := -lz
LOCAL_SRC_FILES := $(LIBCAIRO_SRC)

include $(BUILD_STATIC_LIBRARY)
