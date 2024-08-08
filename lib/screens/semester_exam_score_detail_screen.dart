import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/semester_exam_score_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class SemesterExamScoreDetailScreen
    extends GetView<SemesterExamScoreController> {
  SemesterExamScoreDetailScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('SEMESTER EXAM RESULT'),
                  ),
                  const Divider(),
                  Wrap(
                    children: [
                      const Text('MZU Regn No : '),
                      Text(data.mzu_regn_no ?? ''),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Full Name : '),
                      Text(data.full_name!),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Batch : '),
                      Text('${data.start_year!}-${data.end_year!}'),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Semester : '),
                      Text(data.current_semester.toString()),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text('Programme : '),
                      Text(data.programme_name!),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.semesterSubjectScoreList.length,
                itemBuilder: (c, i) {
                  var myData = controller.semesterSubjectScoreList[i];
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      dense: true,
                      title: Text(myData.name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              const Text(
                                'Credit : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(myData.credit ?? ''),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'Subject : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(myData.code ?? ''),
                            ],
                          ),
                          sizedBox(10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Mark:        ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: Get.width * 0.25,
                                child: TextFormField(
                                  initialValue: myData.mark_obtain == null
                                      ? '0'
                                      : myData.mark_obtain.toString(),
                                  onChanged: (value) {
                                    myData.mark_obtain = int.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      isDense: true),
                                ),
                              ),
                            ],
                          ),
                          sizedBox(10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Full Mark:   ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: Get.width * 0.25,
                                child: TextFormField(
                                  initialValue: myData.full_mark == null
                                      ? '0'
                                      : myData.full_mark.toString(),
                                  onChanged: (value) {
                                    myData.full_mark = int.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      isDense: true),
                                ),
                              ),
                            ],
                          ),
                          sizedBox(10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Grade:       ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: Get.width * 0.25,
                                child: DropdownSearch<String>(
                                  selectedItem: myData.score,
                                  items: const [
                                    'O',
                                    'A+',
                                    'A',
                                    'B+',
                                    'B',
                                    'C',
                                    'F',
                                    'Ab'
                                  ],
                                  onChanged: (value) {
                                    myData.score = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // trailing: SizedBox(
                      //   width: Get.width * 0.25,
                      //   child: DropdownSearch<String>(
                      //     selectedItem: myData.score,
                      //     items: const [
                      //       'O',
                      //       'A+',
                      //       'A',
                      //       'B+',
                      //       'B',
                      //       'C',
                      //       'F',
                      //       'Ab'
                      //     ],
                      //     onChanged: (value) {
                      //       myData.score = value;
                      //     },
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    elevation: 0,
                    color: Colors.white,
                    onPressed: () {},
                    child: const Text('BACK'),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.green,
                    onPressed: () {
                      controller.saveSemesterGrade(() {
                        reusableWidget.showLoader(context);
                      }, () {
                        reusableWidget.hideLoader();
                        Get.back();
                        mySnackBar(
                            'Successfully Saved',
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                            ));
                      }, () {
                        reusableWidget.hideLoader();
                      });
                    },
                    child: const Text('SAVE'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
