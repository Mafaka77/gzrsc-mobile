import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/internal_mark_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class InternalExamMarkWidget extends GetView<InternalMarkController> {
  InternalExamMarkWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () => Text(controller.subject.value),
            ),
          ],
        ),
        Obx(
          () => ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => Container(
                    height: 4,
                  ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.internalExamMarks.length,
              itemBuilder: (c, i) {
                var data = controller.internalExamMarks[i];
                return ListTile(
                  dense: true,
                  tileColor: Colors.white,
                  title: Text(data.name!),
                  subtitle: Text(data.mzu_regn_no!),
                  trailing: SizedBox(
                    width: 60,
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) {
                        controller.internalExamMarks[i].mark_obtain =
                            int.parse(value);
                      },
                      controller: TextEditingController(
                          text: data.mark_obtain.toString()),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                );
              }),
        ),
        sizedBox(10),
        Obx(
          () => controller.internalExamMarks.isEmpty
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      elevation: 0,
                      color: Colors.white,
                      onPressed: () {
                        controller.internalExamMarks.clear();
                        controller.subject.value = '';
                        controller.getAllStudents(() {});
                      },
                      child: const Text('Clear'),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    MaterialButton(
                      elevation: 0,
                      minWidth: 140,
                      color: Colors.green,
                      onPressed: () {
                        controller.submitInternalExamMarks(() {
                          reusableWidget.showLoader(context);
                        }, () {
                          reusableWidget.hideLoader();
                          mySnackBar(
                              'Successfully Updated',
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              ));
                        }, () {
                          reusableWidget.hideLoader();
                          mySnackBar(
                              'Error Occured',
                              const Icon(
                                Icons.warning,
                                color: Colors.red,
                              ));
                        });
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
