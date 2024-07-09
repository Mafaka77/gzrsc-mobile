import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/assign_student_mentor_controller.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/faculty_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/student_mentor_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/screens/student_mentor_detail_screen.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class AssignStudentMentorScreen extends StatelessWidget {
  AssignStudentMentorScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssignStudentMentorController>(
        init: AssignStudentMentorController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                openAddStudentModal(context, controller);
              },
              child: const Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.isLoading.isTrue
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.facultyList.isEmpty
                              ? const Center(
                                  child: Text('No Data'),
                                )
                              : controller.studentList.isEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'LIST OF FACULTIES',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        sizedBox(20),
                                        ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 10,
                                          ),
                                          itemCount:
                                              controller.facultyList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (c, i) {
                                            var data =
                                                controller.facultyList[i];
                                            return ListTile(
                                              onTap: () {
                                                controller.getStudentMentorList(
                                                    data.id!, () {
                                                  reusableWidget
                                                      .showLoader(context);
                                                  Get.to(() =>
                                                      StudentMentorDetailScreen());
                                                }, () {
                                                  reusableWidget.hideLoader();
                                                }, () {
                                                  reusableWidget.hideLoader();
                                                });
                                              },
                                              tileColor: Colors.white,
                                              dense: true,
                                              title: Text(data.name.toString()),
                                              subtitle: Text(
                                                data.departmentModel!.name
                                                    .toString(),
                                              ),
                                              // trailing: IconButton(
                                              //   onPressed: () {},
                                              //   icon: const Icon(
                                              //     Icons.edit,
                                              //     color: Colors.blue,
                                              //   ),
                                              // ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'LIST OF STUDENTS',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        sizedBox(10),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.studentList.length,
                                          itemBuilder: (c, i) {
                                            var data =
                                                controller.studentList[i];
                                            return ListTile(
                                              dense: true,
                                              title: Text(data.full_name!),
                                              subtitle: Text(
                                                data.mzu_regn_no ?? 'N/A',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              leading: Checkbox(
                                                value: data.isSelected,
                                                onChanged: (val) {
                                                  data.isSelected = val;
                                                  controller.update();
                                                  if (val == true) {
                                                    controller.studentMentorList
                                                        .add(StudentMentorModel(
                                                      student_id: data.id,
                                                      programme_id:
                                                          data.programme_id,
                                                      specialization_id: data
                                                          .specialization_id,
                                                      batch_id: data.batch_id,
                                                      semester: int.parse(
                                                          controller
                                                              .semester.value),
                                                      faculty_id: controller
                                                          .faculty_id
                                                          .toInt(),
                                                    ));
                                                  } else {
                                                    controller.studentMentorList
                                                        .removeWhere((element) =>
                                                            element
                                                                .student_id ==
                                                            data.id);
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        MaterialButton(
                                          color: Colors.blue,
                                          minWidth: Get.width,
                                          onPressed: () {
                                            if (controller
                                                .studentMentorList.isEmpty) {
                                              mySnackBar(
                                                'Please select student',
                                                const Icon(
                                                  Icons.warning,
                                                  color: Colors.red,
                                                ),
                                              );
                                            } else {
                                              controller.submitStudentMentor(
                                                  () {
                                                reusableWidget
                                                    .showLoader(context);
                                              }, () {
                                                reusableWidget.hideLoader();
                                                mySnackBar('Successfully Added',
                                                    const Icon(Icons.check));
                                              }, () {
                                                reusableWidget.hideLoader();
                                              });
                                            }
                                          },
                                          child: const Text('SAVE'),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  openAddStudentModal(
      BuildContext context, AssignStudentMentorController controller) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CLOSE'),
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.blue,
                child: const Text('SUBMIT'),
                onPressed: () {
                  controller.getMentorAllStudents(() {
                    reusableWidget.showLoader(context);
                  }, () {
                    reusableWidget.hideLoader();
                    Navigator.pop(context);
                  }, () {
                    mySnackBar(
                      'Error Occured!!',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                    reusableWidget.hideLoader();
                  });
                },
              )
            ],
            content: SizedBox(
              height: Get.height * 0.5,
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
                      controller.course_id.value =
                          value.programModel.course_id!;
                      controller.programData.value = value;
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
                  const SizedBox(
                    height: 10,
                  ),
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
                  reusableWidget.sizedBox(10),
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
                  reusableWidget.sizedBox(10),
                  Obx(
                    () => DropdownSearch<FacultyModel>(
                      selectedItem: controller.facultyData.value,
                      asyncItems: (text) async {
                        var data = await controller.getAllFaculty();
                        // print(data);
                        return data;
                      },
                      onChanged: (value) {
                        controller.faculty_id.value = value!.id!;
                        controller.facultyData.value = value;
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
                          labelText: 'Select Faculty',
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
