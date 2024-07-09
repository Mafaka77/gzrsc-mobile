import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/internal_mark_controller.dart';

class InternalExamMarkDetailScreen extends GetView<InternalMarkController> {
  InternalExamMarkDetailScreen({super.key});
  var studentId = Get.arguments[0];
  var internalExamId = Get.arguments[1];
  var noOfSemester = Get.arguments[2];
  var semester = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    var list = [for (var i = 1; i <= noOfSemester; i++) i];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: list
              .map((e) => Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('SEMESTER - $e'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.internalExamStudentMark
                                  .where((p0) =>
                                      p0.student_id == studentId &&
                                      p0.semester == e)
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) {
                                var data = controller.internalExamStudentMark
                                    .where((d) =>
                                        d.student_id == studentId &&
                                        d.semester == e)
                                    .toList()[i];
                                // var data = controller.internalExamStudentMark
                                //     .where((p0) =>
                                //         p0.student_id == studentId &&
                                //         p0.semester == e);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Internal   :  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(controller
                                            .internalExamStudentMark[i]
                                            .internal_name
                                            .toString()),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        const Text(
                                          'Subject    :  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data.subject_name.toString(),
                                            overflow: TextOverflow.clip),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        const Text(
                                          'Full Mark  :  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data.full_mark.toString(),
                                            overflow: TextOverflow.clip),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        const Text(
                                          'Pass Mark  :  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data.pass_mark.toString(),
                                            overflow: TextOverflow.clip),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        const Text(
                                          'Mark Obtain:  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data.mark_obtain.toString(),
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
