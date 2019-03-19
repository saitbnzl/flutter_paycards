import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPaycards {
  static const MethodChannel _channel =
      const MethodChannel('flutter_paycards');

  static Future<dynamic> get startRecognizer async {
    final dynamic cardsScanResult = await _channel.invokeMethod('startRecognizer');
    return cardsScanResult;
  }
}
