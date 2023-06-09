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
    //JavaScriptChannel을 웹뷰 컨트롤러에 더한다
    ..addJavaScriptChannel(
        //JavaScriptChannel 이름
        "FlutterGetDeviceToken",
        onMessageReceived: (JavaScriptMessage message) async {
          // 리액트로부터 통신을 수신하면 로그로 띄운다.
          logger.d("리액트 수신 완료");

          // 정의한 getDeviceToken 함수로 모바일 토큰 불러옴 -> 통신이랑 무관
          String token = await getDeviceToken();
          // 정의한 함수로 리액트로 모바일 토큰 전송 -> 수신이랑 무관
          sendDeviceToken(token);
        },
    )
    ..addJavaScriptChannel(
        "FlutterGetAuthToken",
        onMessageReceived: (JavaScriptMessage message) async {
          logger.d("리액트 수신 완료");

          //요청에 대한 응답
        },
    )
    ..addJavaScriptChannel(
        "FlutterStoreAuthToken",
        onMessageReceived: (JavaScriptMessage message) async {
          logger.d("리액트 수신 완료");
          //값 전역변수로 저장
        },
    )

    ..loadRequest(Uri.parse('https://www.dev.uspray.kr'));

  WebViewController getController() {
    return controller;
  }

  static void sendDeviceToken(String token){
    logger.d("리액트 송신 완료 - $token}");
    controller.runJavaScript("window.sendDeviceToken(\"$token\");");
  }
  static void sendAuthToken(String token){
    logger.d("리액트 송신 완료");
    controller.runJavaScript("window.sendAuthToken(\"$token\");");
  }

}


