import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/internal_mark_controller.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/widgets/internal_exam_mark_widget.dart';
import 'package:lms/widgets/internal_mark_all_student_widget.dart';
import 'package:lms/widgets/internal_mark_filter_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class InternalMarkScreen extends StatelessWidget {
  const InternalMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InternalMarkController>(
        init: InternalMarkController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.green,
              onPressed: () {
                openFilterPage(controller, context);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('LIST OF INTERNAL EXAM MARKS'),
                      sizedBox(10),
                      Obx(() => controller.internalExamAllStudents.isEmpty
                          ? InternalExamMarkWidget()
                          : InternalMarkAllStudentWidget()),
                      // Obx(
                      //   () => controller.internalExamMarks.isEmpty
                      //       ? Container()
                      //       : const InternalExamMarkWidget(),
                      // ),
                      sizedBox(20)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  openFilterPage(InternalMarkController controller, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return InternalMarkFilterWidget();
        });
  }
}
