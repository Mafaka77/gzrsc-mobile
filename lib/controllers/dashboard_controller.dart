import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/services/dashboard_services.dart';
import 'package:lms/snackbar_widget.dart';

class DashboardController extends GetxController {
  DashboardServices services = Get.find(tag: 'dashboardServices');
  var dashboardData = {}.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getHomeData();
    super.onInit();
  }

  void getHomeData() async {
    isLoading.value = true;
    try {
      var response = await services.getHomeData();
      dashboardData.addAll(response);
      isLoading.value = false;
    } catch (ex) {
      isLoading.value = false;
      mySnackBar(
        'Something went wrong!!',
        const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    }
  }
}
