package com.saitbnzl.flutterPaycards.sdk.utils;

import androidx.annotation.RestrictTo;

import com.saitbnzl.flutterPaycards.BuildConfig;

@RestrictTo(RestrictTo.Scope.LIBRARY)
public class Constants {

    private Constants() { }

    public static final boolean DEBUG = BuildConfig.DEBUG;

    public static final String MODEL_DIR = "model";

    public static final int NEURO_DATA_VERSION = 9;

    public static final String PAYCARDS_URL = "https://pay.cards";
}
