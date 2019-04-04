package com.saitbnzl.flutterPaycards.sdk.ndk;

import androidx.annotation.RestrictTo;

@RestrictTo(RestrictTo.Scope.LIBRARY)
public interface TorchStatusListener {

    void onTorchStatusChanged(boolean turnTorchOn);

}
