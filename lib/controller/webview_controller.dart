import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayhelper/funct/get_device_token.dart';
import 'package:prayhelper/funct/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewMainController extends GetxController {
  static WebviewMainController get to => Get.find();

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) async{
          if (request.url.startsWith('https://accounts.google.com/ServiceLogin')) {
            //TODO: 이 부분을 request 요청을 보내는 것으로 대체
            logger.d(await getDeviceToken());
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://naver.com'));

  WebViewController getController() {
    return controller;
  }
}