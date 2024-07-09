import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/semester_exam_fee_controller.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/all_semester_exam_fee_widget.dart';
import 'package:lms/widgets/semester_exam_fee_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class SemesterExamFeeScreen extends StatelessWidget {
  SemesterExamFeeScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SemesterExamFeeController>(
        init: SemesterExamFeeController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              backgroundColor: Colors.green,
              onPressed: () {
                openDialog(context, controller);
              },
              child: const Icon(Icons.add),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => controller.semesterExamFeeList.isEmpty
                    ? SemesterExamFeeWidget()
                    : AllSemesterExamFeeWidget(),
              ),
            )),
          );
        });
  }

  openDialog(BuildContext context, SemesterExamFeeController controller) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              height: Get.height * 0.4,
              child: Column(
                children: [
                  DropdownSearch<SpecializationModel>(
                    selectedItem: controller.programData.value,
                    asyncItems: (text) async {
                      var data = await controller.getAllProgram();
                      // print(data);
                      return data;
                    },
                    onChanged: (value) {
                      controller.specialization_id.value = value!.id!;
                      controller.programme_id.value = value.programModel.id!;
                      controller.update();
                    },
                    validator: (item) {
                      if (item == null) {
                        return "Required field";
                      }
                      return null;
                    },
                    dropdownButtonProps: const DropdownButtonProps(
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      fit: FlexFit.tight,
                      showSelectedItems: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    compareFn: (item1, item2) => item1.isEqual(item2),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Select Program',
                        border: OutlineInputBorder(),
                        isDense: true,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  sizedBox(10),
                  Obx(
                    () => DropdownSearch<String>(
                      validator: (item) {
                        if (item == null) {
                          return "Required field";
                        }
                        return null;
                      },
                      popupProps: const PopupProps.menu(
                        showSearchBox: false,
                        fit: FlexFit.tight,
                        showSelectedItems: true,
                      ),
                      items: const [
                        "1",
                        "2",
                        "3",
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10'
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Select Semester',
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                      onChanged: (value) {
                        controller.semester.value = value!;
                      },
                      selectedItem: controller.semester.value,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  controller.getSemesterExamFee();
                  Navigator.pop(context);
                },
                child: const Text('CLEAR'),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.green,
                onPressed: () {
                  controller.filterSemesterExamFee(() {
                    reusableWidget.showLoader(context);
                  }, () {
                    Navigator.pop(context);
                    reusableWidget.hideLoader();
                  }, () {
                    mySnackBar(
                        'Error Occured!',
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ));
                    reusableWidget.hideLoader();
                  });
                },
                child: const Text('FILTER'),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        });
  }
}
