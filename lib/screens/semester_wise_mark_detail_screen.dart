import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/semester_exam_score_controller.dart';
import 'package:lms/reusable_widget.dart';

class SemesterWiseMarkDetailScreen
    extends GetView<SemesterExamScoreController> {
  SemesterWiseMarkDetailScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  var semester = Get.arguments[0];
  var start_year = Get.arguments[1];
  var end_year = Get.arguments[2];
  @override
  Widget build(BuildContext context) {
    var list = [for (var i = 1; i <= semester; i++) i];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: reusableWidget.appBarBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...list.map((e) {
              return SizedBox(
                width: Get.width,
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Semester $e -(${start_year + '-' + end_year})  ',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const Divider(),
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.semesterExamMarkList
                                .where((d) => d.semester == e)
                                .length,
                            itemBuilder: (c, i) {
                              var data = controller.semesterExamMarkList
                                  .where((d) => d.semester == e)
                                  .toList()[i];
                              // print(controller.semesterExamMarkList[i].score);
                              return ListTile(
                                dense: true,
                                leading: Column(
                                  children: [
                                    const Text('Score'),
                                    Text(
                                      data.score!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                title: Wrap(
                                  children: [
                                    const Text(
                                      'Subject: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(data.subject_name!),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        const Text(
                                          'CODE : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data.subject_code!)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
