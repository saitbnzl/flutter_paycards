package com.saitbnzl.flutterPaycards.sdk.ndk;

import androidx.annotation.IntRange;

import com.saitbnzl.flutterPaycards.sdk.ndk.RecognitionConstants.WorkAreaOrientation;

public interface DisplayConfiguration {
    @WorkAreaOrientation
    int getNativeDisplayRotation();

    @IntRange(from=0, to=360)
    int getPreprocessFrameRotation(int width, int height);
}
