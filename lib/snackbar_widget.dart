import 'package:flutter/material.dart';
import 'package:get/get.dart';

mySnackBar(String message, Icon icon) {
  return Get.rawSnackbar(
    message: message,
    icon: icon,
    backgroundColor: Colors.black45,
    snackPosition: SnackPosition.TOP,
    borderRadius: 50,
    snackStyle: SnackStyle.FLOATING,
    shouldIconPulse: true,
    barBlur: 20,
    margin: const EdgeInsets.only(
      top: 30,
      left: 40,
      right: 40,
    ),
    isDismissible: true,
    duration: const Duration(milliseconds: 3000),
  );
}
