/*
 * Copyright (C) 2010 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.example.cairo;

import android.app.Activity;
import android.os.Bundle;
import android.content.Context;
import android.view.View;
import android.graphics.Bitmap;
import android.graphics.Canvas;

public class Cairo extends Activity {
    @Override public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(new CairoView(this));
    }

    static {
        System.loadLibrary("java-bitmap");
    }
}

class CairoView extends View {
    /* implementend by libjava-bitmap.so */
    private static native void drawFrame(Bitmap bitmap);

    public CairoView(Context context) {
        super(context);
    }

    @Override protected void onDraw(Canvas canvas) {
        Bitmap bmp = Bitmap.createBitmap(canvas.getWidth(), canvas.getHeight(), Bitmap.Config.RGB_565);

        drawFrame(bmp);
        canvas.drawBitmap(bmp, 0, 0, null);
        invalidate(); /* force redreaw */
    }
}
