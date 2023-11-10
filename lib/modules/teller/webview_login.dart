import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:venus/collection/env.dart';
import 'package:venus/collection/models/teller_config.dart';
import 'package:venus/collection/models/teller_data.dart';
import 'package:venus/composition/teller_stream.dart';
import 'package:venus/utils/platform.dart';

final config = TellerConfig(
  appId: Env.tellerApplicationId,
  environment: Environment.sandbox,
);

final uri = config.toUri();

class TellerWebViewLogin extends HookWidget {
  const TellerWebViewLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onWebViewCreated: (controller) async {
        final isWebMessageListenerSupported = !kIsWeb &&
            (!kIsAndroid ||
                await WebViewFeature.isFeatureSupported(
                  WebViewFeature.WEB_MESSAGE_LISTENER,
                ));

        if (isWebMessageListenerSupported) {
          await controller.addWebMessageListener(
            WebMessageListener(
              jsObjectName: "AndroidApp",
              allowedOriginRules: {"https://teller.io"},
              onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {
                final Map<String, dynamic> data =
                    message != null ? jsonDecode(message) : {};

                if (data["namespace"] != "teller-connect") {
                  return;
                }

                switch (data["event"]) {
                  case "success":
                    tellerSuccessStreamController.add(
                      TellerData.fromJson(data["data"]),
                    );
                    GoRouter.of(context).pop();
                  case "exit":
                    GoRouter.of(context).pop();
                }
              },
            ),
          );
        }

        await controller.loadUrl(
          urlRequest: URLRequest(
            url: WebUri.uri(uri),
          ),
        );
      },
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(
          source: """
                    window.postMessage = function(message, origin, transfer) {
                        window.AndroidApp.postMessage(message);
                  }""",
        );
      },
    );
  }
}
