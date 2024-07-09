import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/assign_student_mentor_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class StudentMentorDetailScreen extends GetView<AssignStudentMentorController> {
  StudentMentorDetailScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(
            () => controller.mentoredStudentsList.isEmpty
                ? const Center(
                    child: Text('No Data'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.mentoredStudentsList.length,
                    itemBuilder: (c, i) {
                      var data = controller.mentoredStudentsList[i];
                      return ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            data['specialization'],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data['data'].length,
                                  itemBuilder: (c, i) {
                                    var d = data['data'][i];
                                    return ListTile(
                                      onTap: () {
                                        controller.infoTextController.text =
                                            d['any_other_info'] ?? '';
                                        openDialog(
                                          context,
                                          d['student']['profile']['name'],
                                          d['id'],
                                          d['faculty_id'],
                                        );
                                      },
                                      contentPadding: const EdgeInsets.all(10),
                                      tileColor: Colors.white,
                                      dense: true,
                                      title: Text(d['student']['profile']
                                              ['name']
                                          .toString()),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            children: [
                                              const Text('Parent: '),
                                              Text(d['student']['profile']
                                                      ['fathers_name']
                                                  .toString())
                                            ],
                                          ),
                                          Wrap(
                                            children: [
                                              const Text('Mobile: '),
                                              Text(d['student']['profile']
                                                      ['fathers_mobile'] ??
                                                  'N/A')
                                            ],
                                          ),
                                          Wrap(
                                            children: [
                                              const Text('Address: '),
                                              Text(d['student']['profile']
                                                      ['permanent_address'] ??
                                                  'N/A')
                                            ],
                                          ),
                                          Wrap(
                                            children: [
                                              const Text('Guardian: '),
                                              Wrap(
                                                children: [
                                                  Text(d['student']['profile']
                                                          ['guardian_name'] ??
                                                      'N/A'),
                                                  const Text(','),
                                                  Text(d['student']['profile']
                                                          ['guardian_mobile'] ??
                                                      'N/A')
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ]);
                    },
                  ),
          ),
        ]),
      ),
    );
  }

  openDialog(BuildContext context, String name, int id, int facultyId) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            elevation: 0,
            content: SizedBox(
              height: Get.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('UPDATE - $name'),
                  sizedBox(10),
                  TextField(
                    controller: controller.infoTextController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Any other information (including ambition & issues faced)',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  controller.updateInfo(id, () {
                    reusableWidget.showLoader(context);
                  }, () {
                    mySnackBar(
                      'Info Updated',
                      const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    );
                    reusableWidget.hideLoader();
                    Navigator.pop(context);
                    controller.getStudentMentorList(
                        facultyId, () {}, () {}, () {});
                  }, () {
                    mySnackBar(
                      'Error Occured',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                    reusableWidget.hideLoader();
                  });
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }
}
