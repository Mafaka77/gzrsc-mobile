import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/colors.dart';
import 'package:lms/controllers/attendance_controller.dart';
import 'package:lms/widgets/all_attendance_widget.dart';
import 'package:lms/widgets/attendance_filter_widget.dart';
import 'package:lms/widgets/attendance_list_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AttendanceController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                openAddDialog(context);
              },
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AttendanceFilterWidget(),
                        Obx(
                          () => controller.attendanceList.isTrue
                              ? AttendanceList()
                              : AllAttendanceWidget(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void openAddDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              height: Get.height * 0.9,
              child: AttendanceFilterWidget(),
            ),
          );
        });
  }
}
