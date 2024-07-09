import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/colors.dart';
import 'package:lms/controllers/attendance_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class AttendanceList extends GetView<AttendanceController> {
  AttendanceList({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => controller.studentAttendance.isEmpty
            ? Container()
            : const Text('Student List')),
        sizedBox(10),
        Wrap(
          children: [
            Text('No of class: ${controller.noOfClass.text} |'),
            Text('Month: ${controller.monthDisplay.value.toString()} |'),
            Text('Year: ${controller.year.value}')
          ],
        ),
        sizedBox(10),
        Obx(
          () => controller.studentAttendance.isEmpty
              ? const Center(
                  child: Text('No Data'),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.studentAttendance.length,
                  itemBuilder: (c, i) {
                    var data = controller.studentAttendance[i];
                    return Card(
                      elevation: 0,
                      child: ListTile(
                        dense: true,
                        // leading: Text(data['batch']
                        //         ['current_semester']
                        //     .toString()),
                        title: Text(data.name.toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                const Text('Regn No : '),
                                Text(data.mzu_regn_no ?? ''),
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('Subject : '),
                                Text(controller.subject_name.toString() ?? ''),
                              ],
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 60,
                          height: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              controller.studentAttendance[i].attendance =
                                  int.parse(value);
                            },
                            controller: TextEditingController(
                                text: data.attendance.toString()),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        sizedBox(10),
        Obx(
          () => controller.studentAttendance.isEmpty
              ? Container()
              : MaterialButton(
                  minWidth: Get.width,
                  color: MyColors.buttonColor,
                  onPressed: () {
                    controller.submitAttendance(() {
                      reusableWidget.showLoader(context);
                    }, () {
                      mySnackBar(
                        'Attendance Updated',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                      );
                      reusableWidget.hideLoader();
                    }, () {
                      mySnackBar(
                        'Error Occured!',
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                      );
                      reusableWidget.hideLoader();
                    });
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ),
        sizedBox(30)
      ],
    );
  }
}
