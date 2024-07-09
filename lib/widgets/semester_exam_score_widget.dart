import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/semester_exam_score_controller.dart';
import 'package:lms/models/student_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/screens/semester_exam_score_detail_screen.dart';
import 'package:lms/screens/semester_wise_mark_detail_screen.dart';

class SemesterExamScoreWidget extends GetView<SemesterExamScoreController> {
  SemesterExamScoreWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.semesterExamScoreList.length,
          itemBuilder: (c, i) {
            var data = controller.semesterExamScoreList[i];
            return Card(
              elevation: 0,
              child: ListTile(
                dense: true,
                title: Text(data.full_name!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        const Text(
                          'Regn No : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data.mzu_regn_no != null
                            ? data.mzu_regn_no.toString()
                            : ''),
                      ],
                    ),
                    Wrap(
                      children: [
                        const Text(
                          'Programme : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${data.programme_code}-${data.specialization_name!}'),
                      ],
                    ),
                    Wrap(
                      children: [
                        const Text(
                          'Batch : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${data.start_year}-${data.end_year!}(${data.current_semester})'),
                      ],
                    )
                  ],
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                      color: Colors.green,
                      onPressed: () {
                        controller.getSemesterMarkDetails(
                            data.id!, data.current_semester!, () {
                          reusableWidget.showLoader(context);
                        }, () {
                          reusableWidget.hideLoader();
                          Get.to(
                            () => SemesterWiseMarkDetailScreen(),
                            arguments: [
                              data.programme_semester,
                              data.start_year,
                              data.end_year,
                            ],
                          );
                        }, () {
                          reusableWidget.hideLoader();
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    IconButton(
                      color: Colors.green,
                      onPressed: () {
                        controller.getSubjectBasedOnId(
                            data.batch_id!,
                            data.id!,
                            int.parse(controller.semester.toString()),
                            data.specialization_id!,
                            data.programme_id!, () {
                          reusableWidget.showLoader(context);
                        }, () {
                          Get.to(() => SemesterExamScoreDetailScreen(),
                              arguments: [data]);
                          reusableWidget.hideLoader();
                        }, () {
                          reusableWidget.hideLoader();
                        });
                      },
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
