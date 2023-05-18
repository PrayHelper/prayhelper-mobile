import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prayhelper/func/getDeviceId.dart';
import 'package:prayhelper/pray_helper_app.dart';
import 'controller/webview_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(WebviewMainController());
  runApp(PrayHelperApp());
}

