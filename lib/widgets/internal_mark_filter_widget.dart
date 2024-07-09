import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/internal_mark_controller.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class InternalMarkFilterWidget extends GetView<InternalMarkController> {
  InternalMarkFilterWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('FILTER'),
                sizedBox(10),
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
                      var data = await controller.getAllBatch();
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
                TextFormField(
                  controller: controller.passMark,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Pass Mark';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    labelText: 'Pass Mark',
                  ),
                ),
                sizedBox(10),
                TextFormField(
                  controller: controller.fullMark,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Full Mark';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    labelText: 'Full Mark',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(
              width: 20,
            ),
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                filterInternalMarks(context);
              },
              child: const Text(
                'Filter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }

  void filterInternalMarks(BuildContext context) {
    if (controller.formKey.currentState!.validate()) {
      controller.filterInternalExamMarks(() {
        reusableWidget.showLoader(context);
        // controller.attendanceList.value = true;
      }, () {
        controller.update();
        Navigator.pop(context);
        reusableWidget.hideLoader();
      }, () {
        reusableWidget.hideLoader();
      });
    } else {}
  }
}
