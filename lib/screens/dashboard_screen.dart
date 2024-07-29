import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/controllers/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  GetStorage storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                  () => controller.isLoading.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            Card(
                              elevation: 0,
                              child: ListTile(
                                title: const Text('Application | All'),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      controller.dashboardData['application']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: ListTile(
                                title: const Text('Student | All'),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      controller.dashboardData['student']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: ListTile(
                                title: const Text(
                                  'Faculty | All',
                                  style: TextStyle(
                                    color: FlexColor.blueDarkTertiaryContainer,
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      controller.dashboardData['faculty']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                )),
          );
        });
  }
}
