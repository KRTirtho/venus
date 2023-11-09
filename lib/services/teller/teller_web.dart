// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:js';
import 'dart:js_util';

import 'package:venus/collection/env.dart';

void _sendTellerMessage(String message) {
  print("Got message from teller: $message");
}

void setupTellerWeb() async {
  setProperty(window, "sendTellerMessage", allowInterop(_sendTellerMessage));
  await context.callMethod('setupTellerConnect', [Env.tellerApplicationId]);
}

Future<void> openTellerConnect() async {
  await context.callMethod('openTellerConnect', []);
}
