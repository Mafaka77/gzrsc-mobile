import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/internal_exam_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class AddInternalExamScreen extends StatelessWidget {
  AddInternalExamScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InternalExamController>(
        init: InternalExamController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.internalName.clear();
                  controller.internalCode.clear();
                  controller.status.value = '';
                  openDialog(context, controller, 0);
                },
                child: const Icon(
                  Icons.add,
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LIST OF INTERNAL EXAMINATIONS',
                      style: TextStyle(fontSize: 15),
                    ),
                    sizedBox(10),
                    Obx(
                      () => controller.onLoading.isTrue
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 4,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.internalExamList.length,
                              itemBuilder: (c, i) {
                                var data = controller.internalExamList[i];
                                return ListTile(
                                  tileColor: Colors.white,
                                  dense: true,
                                  title: Text(data.name.toString()),
                                  subtitle: Wrap(
                                    children: [
                                      Text(
                                        data.code.toString(),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        data.status.toString(),
                                        style: TextStyle(
                                          color: (data.status == 'active'
                                              ? Colors.green
                                              : Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.internalName.text =
                                                data.name!;
                                            controller.internalCode.text =
                                                data.code!;
                                            controller.status.value =
                                                data.status!;
                                            openDialog(
                                                context, controller, data.id!);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog.adaptive(
                                                    title: const Text(
                                                        'Are you sure?'),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          controller
                                                              .deleteInternalExam(
                                                                  data.id!, () {
                                                            reusableWidget
                                                                .showLoader(
                                                                    context);
                                                          }, () {
                                                            Navigator.pop(
                                                                context);
                                                            reusableWidget
                                                                .hideLoader();
                                                            Get.back();
                                                            mySnackBar(
                                                                'Successfully Deleted!',
                                                                const Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .blue,
                                                                ));
                                                          }, () {
                                                            mySnackBar(
                                                                'Error Occured!',
                                                                const Icon(
                                                                  Icons.warning,
                                                                  color: Colors
                                                                      .red,
                                                                ));
                                                            reusableWidget
                                                                .hideLoader();
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Delete'),
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void openDialog(
      BuildContext context, InternalExamController controller, int id) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              height: Get.height * 0.5,
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add Internal Exam'),
                    sizedBox(15),
                    TextFormField(
                      controller: controller.internalName,
                      decoration: const InputDecoration(
                        labelText: 'Enter Internal Name',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    sizedBox(10),
                    TextFormField(
                      controller: controller.internalCode,
                      decoration: const InputDecoration(
                        labelText: 'Enter Internal Code',
                        border: OutlineInputBorder(),
                        isDense: true,
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
                          "active",
                          "inactive",
                        ],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: 'Select Status',
                            border: OutlineInputBorder(),
                            isDense: true,
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                        onChanged: (value) {
                          controller.status.value = value!;
                        },
                        selectedItem: controller.status.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Close'),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.green,
                onPressed: () {
                  controller.addInternalExam(id, () {
                    reusableWidget.showLoader(context);
                  }, () {
                    reusableWidget.hideLoader();
                    Get.back();
                    mySnackBar(
                      'Internal Successfully Added',
                      const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    );
                  }, () {
                    reusableWidget.hideLoader();
                    mySnackBar(
                      'Error Occured!! Try Again',
                      const Icon(
                        Icons.check,
                        color: Colors.red,
                      ),
                    );
                  });
                },
                child: const Text('SAVE'),
              )
            ],
          );
        });
  }
}
