import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:venus/modules/teller/webview_login.dart';

class TellerScreen extends HookWidget {
  const TellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: TellerWebViewLogin()),
    );
  }
}
