import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: WebViewWidget(controller: widget.controller),
        onWillPop: (){
          return onGoBack();
        }
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> onGoBack() async {
    if (await widget.controller.canGoBack()) {
      widget.controller.goBack();
      return Future.value(false);
    } else {
      Future<bool> dialogResult = showExitPopup();
      return Future.value(dialogResult);
    }
  }
}
