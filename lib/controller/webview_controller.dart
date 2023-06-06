import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayhelper/func/get_device_token.dart';
import 'package:prayhelper/func/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewMainController extends GetxController {
  static WebviewMainController get to => Get.find();

  static var controller = WebViewController()
    ..enableZoom(false)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) async{
          //TODO 특정 url을 따른 로직을 핸들링할 수 있음
          return NavigationDecision.navigate;
        },
      ),
    )
    ..addJavaScriptChannel(
        "LoginToaster",
        onMessageReceived: (JavaScriptMessage message) async {
          var data = jsonDecode(message.message);
          logger.d(data['loginRequest']);
          //요청에 대한 응답
          if(data['loginRequest']){
            String token = await getDeviceToken();
            sendDeviceToken(token);
          }
        }
    )
    ..loadRequest(Uri.parse('https://www.dev.uspray.kr'));



  WebViewController getController() {
    return controller;
  }

  static void sendDeviceToken(String token){
    controller.runJavaScript("window.getDeviceToken(\"$token\");");
  }

}


