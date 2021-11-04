import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPaycards {
  static const MethodChannel _channel =
  const MethodChannel('flutter_paycards');

  static Future<dynamic> startRecognizer({bool fullScreen:false, String cancelLabel ="Cancel"}) async {
    final dynamic cardsScanResult = await _channel.invokeMethod('startRecognizer', <String, dynamic>{
      'fullScreen': fullScreen,
      'cancelLabel': cancelLabel
    });
    return cardsScanResult;
  }
}
