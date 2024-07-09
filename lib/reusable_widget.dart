import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:lms/colors.dart';

class ReusableWidget {
  showLoader(BuildContext context) {
    Loader.show(context,
        overlayColor: Colors.transparent,
        progressIndicator: Platform.isIOS
            ? const CupertinoActivityIndicator(
                color: Colors.black,
                radius: 12,
              )
            : CircularProgressIndicator(
                color: MyColors.buttonColor,
              ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.green)));
  }

  hideLoader() {
    Loader.hide();
  }

  appBarBackButton() {
    IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.abc_outlined,
          color: Colors.black,
        ));
  }

  sizedBox(double a) {
    return SizedBox(
      height: a,
    );
  }
}
