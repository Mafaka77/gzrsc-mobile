import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/semester_exam_fee_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class SemesterExamFeeWidget extends GetView<SemesterExamFeeController> {
  SemesterExamFeeWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.semesterSubjectFeeList.length,
              itemBuilder: (c, i) {
                var data = controller.semesterSubjectFeeList[i];
                return Card(
                  elevation: 0,
                  child: ListTile(
                    dense: true,
                    title:
                        Text('${data.programme_code} - ${data.programme_name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            const Text('Semester : '),
                            Text(data.semester.toString())
                          ],
                        ),
                        Wrap(
                          children: [
                            const Text('Subject : '),
                            Text(
                              data.name.toString() + data.code.toString(),
                            ),
                          ],
                        ),
                        sizedBox(10),
                        SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: data.amount.toString()),
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              data.amount = value;
                            },
                          ),
                        ),
                        sizedBox(10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            () => controller.semesterSubjectFeeList.isEmpty
                ? Container()
                : MaterialButton(
                    minWidth: Get.width * 0.5,
                    elevation: 0,
                    color: Colors.green,
                    onPressed: () {
                      controller.saveSemesterExamFee(() {
                        reusableWidget.showLoader(context);
                      }, () {
                        reusableWidget.hideLoader();
                        mySnackBar(
                          'Success',
                          const Icon(
                            Icons.check,
                            color: Colors.blue,
                          ),
                        );
                      }, () {
                        reusableWidget.hideLoader();
                        mySnackBar(
                          'Error Occured!',
                          const Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                        );
                      });
                    },
                    child: const Text('SAVE'),
                  ),
          ),
          sizedBox(20)
        ],
      ),
    );
  }
}
