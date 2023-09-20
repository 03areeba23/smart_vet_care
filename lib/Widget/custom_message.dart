import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMessage {
  static cutomToastMsg(
      {String? title, String? error, Color? color, Widget? icon}) {
    Get.snackbar(title!, error!,
        backgroundColor: color!,
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(microseconds: 1),
        colorText: Colors.white,
        icon: icon,
        dismissDirection: DismissDirection.down,
        snackPosition: SnackPosition.BOTTOM,
        showProgressIndicator: true);
  }
}
