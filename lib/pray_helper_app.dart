import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prayhelper/screen/WebViewScreen.dart';
import 'package:prayhelper/screen/SplashScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'controller/webview_controller.dart';

class PrayHelperApp extends StatelessWidget {
  PrayHelperApp({super.key});

  // 앱 정보 저장
  @override
  Widget build(BuildContext context) {
    final controller = WebviewMainController.to
        .getController();

    return FutureBuilder<List<String>?>(
      future: Future.wait(
          [
            SplashDelay.waiting(),
            //Fetching WebPage
          ],
      ),
      builder: (context, AsyncSnapshot<List<String>?> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              //테마설정
              primarySwatch: Colors.blue,
            ),
            home:SafeArea(
              child: WebViewScreen(controller: controller),)
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}