import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/attendance_controller.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/month_model.dart';
import 'package:lms/models/program_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class AttendanceFilterWidget extends GetView<AttendanceController> {
  AttendanceFilterWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      // child: ExpansionTile(
      //   maintainState: true,
      //   controller: controller.expansionController,
      //   childrenPadding:
      //       const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      //   title: const Text('Filter'),
      //   initiallyExpanded: controller.expansionState.value,
      //   children: [
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
              controller.program_id.value = value.programModel.id!;
              controller.course_id.value = value.programModel.course_id!;
              controller.semester.value = '';
              controller.batchData.value = null;
              controller.subjectData.value = null;
              controller.internalExamData.value = null;
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
            () => DropdownSearch<BatchModel>(
              selectedItem: controller.batchData.value,
              asyncItems: (text) async {
                var data = await controller.getBatch();
                // print(data);
                return data;
              },
              onChanged: (value) {
                controller.batch_id.value = value!.id!;
                controller.course_id.value = value.course_id!;
                controller.batchData.value = value;
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
                  labelText: 'Select Batch',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: Icon(Icons.search),
                ),
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
              items: const ["1", "2", "3", '4', '5', '6', '7', '8', '9', '10'],
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
          sizedBox(10),
          Obx(
            () => DropdownSearch<SubjectModel>(
              validator: (item) {
                if (item == null) {
                  return "Required field";
                }
                return null;
              },
              selectedItem: controller.subjectData.value,
              asyncItems: (text) async {
                var data = await controller.getAllSubject();
                // print(data);
                return data;
              },
              onChanged: (value) {
                controller.subject_id.value = value!.id!;
                controller.subject_name.value = value.name!;
                // controller.course_id.value = value.course_id!;
                controller.subjectData.value = value;
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
                  labelText: 'Select Subject',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          sizedBox(10),
          Obx(
            () => DropdownSearch<InternalExamModel>(
              validator: (item) {
                if (item == null) {
                  return "Required field";
                }
                return null;
              },
              selectedItem: controller.internalExamData.value,
              asyncItems: (text) async {
                var data = await controller.getAllInternalExam();
                // print(data);
                return data;
              },
              onChanged: (value) {
                controller.internal_exam_id.value = value!.id!;
                // controller.course_id.value = value.course_id!;
                controller.internalExamData.value = value;
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
                  labelText: 'Select Internal',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          sizedBox(10),
          TextFormField(
            controller: controller.noOfClass,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter No of Class';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              labelText: 'Out of(No of Class)',
            ),
          ),
          sizedBox(10),
          Obx(
            () => DropdownSearch<MonthModel>(
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
              // items: controller.monthList,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Select Month',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              asyncItems: (text) async {
                var data = await controller.getMonth();
                // print(data);
                return data;
              },
              selectedItem: controller.monthData.value,
              compareFn: (item1, item2) => item1.isEqual(item2),
              onChanged: (value) {
                controller.month.value = value!.id!;
                controller.monthDisplay.value = value.month!;
              },
              // selectedItem: controller.monthList.value,
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
              items: controller.yearList,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Select Year',
                  border: OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              onChanged: (value) {
                controller.year.value = value!;
              },
              selectedItem: controller.year.value,
            ),
          ),
          sizedBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Colors.blue,
                minWidth: Get.width * 0.4,
                height: 40,
                onPressed: () {
                  filter(context);
                },
                elevation: 0,
                child: const Text(
                  'FILTER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
      //   ],
      // ),
    );
  }

  void filter(BuildContext context) {
    if (controller.formKey.currentState!.validate()) {
      controller.filterAttendance(() {
        reusableWidget.showLoader(context);
        controller.attendanceList.value = true;
      }, () {
        controller.expansionController.collapse();
        controller.update();
        reusableWidget.hideLoader();
      }, () {
        reusableWidget.hideLoader();
      });
    } else {}
  }
}
