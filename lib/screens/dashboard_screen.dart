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
              child: Column(
                children: [
                  const Text('data'),
                  MaterialButton(
                    child: const Text('Delete'),
                    onPressed: () async {
                      print('Hello');
                      await storage.erase();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
