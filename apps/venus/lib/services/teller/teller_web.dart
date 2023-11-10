// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'dart:js_util';

import 'package:venus/collection/env.dart';
import 'package:venus/collection/models/teller_data.dart';
import 'package:venus/composition/teller_stream.dart';

void _sendTellerMessage(String message) {
  tellerSuccessStreamController.add(TellerData.fromJson(jsonDecode(message)));
}

void setupTellerWeb() async {
  setProperty(window, "sendTellerMessage", allowInterop(_sendTellerMessage));
  await context.callMethod('setupTellerConnect', [Env.tellerApplicationId]);
}

Future<void> openTellerConnect() async {
  await context.callMethod('openTellerConnect', []);
}
