# flutter_paycards

[![pub package](https://img.shields.io/pub/v/flutter_paycards.svg)](https://pub.dartlang.org/packages/flutter_paycards)

This is a Flutter plugin for [PayCards SDK](https://github.com/faceterteam/PayCards_Source). 

Work in progress ⏳

*This plugin requires AndroidX migration in Android.

## Usage

`import 'package:flutter_paycards/flutter_paycards.dart';`


`Map<dynamic, dynamic> results = await FlutterPaycards.startRecognizer(fullScreen: false);`

**cancelLabel** sets the label for cancel button

The map returned from startRecognizer() will have below key/values:


| Key                | Type    |
| ------------------ |:-------:|
| cardHolderName     | String  |
| cardNumber         | String  |
| redactedCardNumber | String  |
| expiryMonth        | int     |
| expiryYear         | int     |
| cvv                | String  |
| postalCode         | String  |