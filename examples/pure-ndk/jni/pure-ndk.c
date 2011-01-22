#include <android_native_app_glue.h>

#include <stdbool.h>
#include <errno.h>
#include <jni.h>
#include <sys/time.h>
#include <time.h>
#include <android/log.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "cairo/src/cairo.h"

#define  LOG_TAG    "android-cairo-pure-ndk"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGW(...)  __android_log_print(ANDROID_LOG_WARN,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

bool app_has_focus = false;
int  tick          = 0;

static void draw_frame(ANativeWindow_Buffer *buffer);
static void handle_app_command(struct android_app* app, int32_t cmd);
static int32_t handle_input(struct android_app* app, AInputEvent* event);


void android_main(struct android_app* app) {
    // Make sure glue isn't stripped.
    app_dummy();

    app->userData = NULL;
    app->onAppCmd = handle_app_command;
    app->onInputEvent = handle_input;

    while (1) {
        // Read all pending events. If app_has_focus is true, then we are going 
        // to read any events that are ready then render the screen. If we don't
        // have focus, we are going to block and spin around the poll loop until
        // we get focus again, preventing us from doing a bunch of rendering 
        // when the app isn't even visible.
        int ident;
        int events;
        struct android_poll_source* source;

        while ((ident=ALooper_pollAll(app_has_focus ? 0 : -1, NULL, &events, (void**)&source)) >= 0) {
            // Process this event.
            if (source != NULL) {
                source->process(app, source);
            }

            // Check if we are exiting.
            if (app->destroyRequested != 0) {
                LOGI("Engine thread destroy requested!");
                return;
            }
        }


        /* Now that we've delt with input, draw stuff */
        if (app->window != NULL) {
            ++tick;
            LOGI("Rendering frame %d", tick);
            ANativeWindow_Buffer buffer;
            if (ANativeWindow_lock(app->window, &buffer, NULL) < 0) {
                LOGW("Unable to lock window buffer");
                continue;
            }

            draw_frame(&buffer);

            ANativeWindow_unlockAndPost(app->window);
        }
    }
}


static void handle_app_command(struct android_app* app, int32_t cmd) {
    /* app->userData is available here */

    switch (cmd) {
        case APP_CMD_INIT_WINDOW:
            app_has_focus=true;
            break;
        case APP_CMD_LOST_FOCUS:
            app_has_focus=false;
            break;
        case APP_CMD_GAINED_FOCUS:
            app_has_focus=true;
            break;
    }
}

static int32_t handle_input(struct android_app* app, AInputEvent* event) {
    /* app->userData is available here */

    if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_MOTION) {
        app_has_focus = true;
        return 1;
    } else if (AInputEvent_getType(event) == AINPUT_EVENT_TYPE_KEY) {
        LOGI("Key event: action=%d keyCode=%d metaState=0x%x",
                AKeyEvent_getAction(event),
                AKeyEvent_getKeyCode(event),
                AKeyEvent_getMetaState(event));
    }

    return 0;
}



static void draw_frame(ANativeWindow_Buffer *buffer) {
    int pixel_size = 0;
    cairo_surface_t *surface = NULL;

    /* Setup our cairo surface to render directly to the native window buffer */
    if (buffer->format == WINDOW_FORMAT_RGB_565) {
        pixel_size = 2;
        surface = cairo_image_surface_create_for_data(buffer->bits, CAIRO_FORMAT_RGB16_565, buffer->width, buffer->height, buffer->stride*pixel_size);
    } else if (buffer->format == WINDOW_FORMAT_RGBA_8888 || buffer->format == WINDOW_FORMAT_RGBX_8888) {
        pixel_size = 4;
        surface = cairo_image_surface_create_for_data(buffer->bits, CAIRO_FORMAT_RGB24, buffer->width, buffer->height, buffer->stride*pixel_size);
    } else {
        LOGE("Unsupported buffer format: %d", buffer->format);
        return;
    }

    cairo_t         *cr      = cairo_create(surface);

    /* clear the screen */
    memset(buffer->bits, 0, buffer->stride*pixel_size*buffer->height);

    /* Normalize our canvas size to make our lives easier */
    cairo_scale(cr, buffer->width, buffer->height);


    /* Draw the big X */
    double position = (tick%30)*(1.0/30);
    cairo_set_source_rgba (cr, 0.5, 0.5, 0.5, 0.7);
    cairo_move_to (cr, 0.1, position);
    cairo_line_to (cr, 0.9, 1.0-position);
    cairo_move_to (cr, 0.9, position);
    cairo_line_to (cr, 0.1, 1.0-position);
    cairo_set_line_width (cr, 0.1);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_stroke (cr);

    /* Draw three color squares */
    cairo_rectangle (cr, 0, 0,0.5, 0.5);
    cairo_set_source_rgba (cr, 1, 0, 0, 0.50);
    cairo_fill (cr);

    cairo_rectangle (cr, 0, 0.5, 0.5, 0.5);
    cairo_set_source_rgba (cr, 0, 1, 0, 0.50);
    cairo_fill (cr);

    cairo_rectangle (cr, 0.5, 0, 0.5, 0.5);
    cairo_set_source_rgba (cr, 0, 0, 1, 0.50);
    cairo_fill (cr);

    /* Draw a more complicated path */
    cairo_set_line_width (cr, 0.04);
    cairo_scale(cr, 0.5, 0.5);
    cairo_translate(cr, 0.5, 1.0);
    cairo_set_source_rgba (cr, 1.0, 0.2, 0.0, 0.5);
    cairo_move_to (cr, 0.25, 0.25);
    cairo_line_to (cr, 0.5, 0.375);
    cairo_rel_line_to (cr, 0.25, -0.125);
    cairo_arc (cr, 0.5, 0.5, 0.25 * sqrt(2), -0.25 * M_PI, 0.25 * M_PI);
    cairo_rel_curve_to (cr, -0.25, -0.125, -0.25, 0.125, -0.5, 0);
    cairo_close_path (cr);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_BUTT);
    cairo_stroke (cr);

    /* Clean up. */
    cairo_destroy(cr);
    cairo_surface_destroy(surface);
}
