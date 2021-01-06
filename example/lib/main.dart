import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_paycards/flutter_paycards.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _cardScanResult;

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanCard() async {
    dynamic cardScanResult;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      cardScanResult = await FlutterPaycards.startRecognizer(cancelLabel: 'Cancel');
      debugPrint("cardScanResult $cardScanResult");
    } on PlatformException {
      debugPrint("PlatformException");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _cardScanResult = cardScanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayCards Plugin Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: RaisedButton(
                    onPressed: () {
                      scanCard();
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Scan Card",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
                _cardScanResult != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Card Number: ${_cardScanResult['cardNumber']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Card Holder Name: ${_cardScanResult['cardHolderName']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Expiry Date: ${_cardScanResult['expiryMonth']}/${_cardScanResult['expiryYear']}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
