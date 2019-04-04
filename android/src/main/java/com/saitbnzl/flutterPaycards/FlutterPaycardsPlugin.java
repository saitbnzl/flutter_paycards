package com.saitbnzl.flutterPaycards;

import android.app.Activity;
import android.content.Intent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.saitbnzl.flutterPaycards.sdk.ui.ScanCardActivity;

/** FlutterPaycardsPlugin */
public class FlutterPaycardsPlugin implements MethodCallHandler {
  Registrar mRegistrar;

  static final int REQUEST_CODE_SCAN_CARD = 1;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_paycards");
    FlutterPaycardsPlugin instance = new FlutterPaycardsPlugin(registrar);
    channel.setMethodCallHandler(instance);
  }

  private FlutterPaycardsPlugin(PluginRegistry.Registrar registrar) {
    mRegistrar = registrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    Activity activity = mRegistrar.activity();
    if (call.method.equals("startRecognizer")) {
      Intent scanIntent = new Intent(activity, ScanCardActivity.class);
      activity.startActivityForResult(scanIntent, REQUEST_CODE_SCAN_CARD);
    } else {
      result.notImplemented();
    }
  }
}
