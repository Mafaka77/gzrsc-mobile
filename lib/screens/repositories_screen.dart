import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/controllers/repositories_controller.dart';
import 'package:lms/models/repository_category_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/services/routes.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RepositoriesScreen extends StatelessWidget {
  RepositoriesScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RepositoriesController>(
        init: RepositoriesController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.isEdit.value = false;
                controller.clearForm();
                controller.update();
                openAddDialog(context, controller, 0);
              },
              child: const Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LIST OF REPOSITORIES',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    sizedBox(20),
                    Obx(
                      () => ListView.separated(
                          separatorBuilder: (context, index) => sizedBox(10),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.respositoriesList.length,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            var data = controller.respositoriesList[i];
                            return ListTile(
                              onTap: () {
                                controller.isEdit.value = true;
                                controller.update();
                                controller.titleTextController.text =
                                    data.title!;
                                controller.descriptionTextController.text =
                                    data.description!;
                                controller.dateTextController.text = data.date!;
                                controller.categoryData.value =
                                    data.repositoryCategoryModel;
                                controller.categoryId.value =
                                    data.repository_category_id!;
                                controller.attachmentController.text =
                                    data.attachments!;
                                controller.status.value = data.status!;
                                controller.attachmentFile = File('');
                                openAddDialog(context, controller, data.id!);
                              },
                              dense: true,
                              tileColor: Colors.white,
                              title: Text(
                                data.title!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      const Text(
                                        'Category: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(data.repositoryCategoryModel.name!)
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      const Text(
                                        'Submitted By: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(data.submittedByModel.name!)
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      const Text(
                                        'Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data.status == 'active'
                                            ? 'Active'
                                            : 'Inactive',
                                        style: TextStyle(
                                            color: data.status == 'active'
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Attachments: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          downloadFile(data.attachments!);
                                        },
                                        child: const Text('Download'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  openDeleteDialog(
                                      context, controller, data.id!);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  openAddDialog(
      BuildContext context, RepositoriesController controller, int id) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              height: Get.height,
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const Text(' REPOSITORIES'),
                    sizedBox(20),
                    DropdownSearch<RepositoryCategoryModel>(
                      selectedItem: controller.categoryData.value,
                      asyncItems: (text) async {
                        var data = await controller.getAllCategories();
                        // print(data);
                        return data;
                      },
                      onChanged: (value) {
                        controller.categoryId.value = value!.id!;
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
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                          isDense: true,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    sizedBox(10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required field *';
                        }
                        return null;
                      },
                      controller: controller.titleTextController,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                      ),
                    ),
                    sizedBox(10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required field *';
                        }
                        return null;
                      },
                      maxLines: 4,
                      controller: controller.descriptionTextController,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                      ),
                    ),
                    sizedBox(10),
                    Obx(
                      () => TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Required field *';
                        //   }
                        //   return null;
                        // },
                        onTap: () async {
                          var permission = await Permission.storage.status;
                          if (permission.isDenied) {
                            await Permission.storage.request();
                          } else {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if (result != null) {
                              controller.isAttachmentPicked.value = true;
                              File file = File(result.files.single.path!);
                              String name =
                                  result.files.single.path!.split('/').last;
                              controller.attachmentController.text = name;
                              controller.attachmentFile = file;
                            } else {
                              controller.isAttachmentPicked.value = false;
                            }
                          }
                        },
                        readOnly: true,
                        controller: controller.attachmentController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Attachment',
                          suffixIcon: controller.isAttachmentPicked.isTrue
                              ? IconButton(
                                  onPressed: () {
                                    controller.isAttachmentPicked.value = false;
                                    controller.attachmentFile = File('');
                                    controller.attachmentController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                  ))
                              : Container(),
                        ),
                      ),
                    ),
                    sizedBox(10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required field *';
                        }
                        return null;
                      },
                      onTap: () {
                        pickDate(context, controller);
                      },
                      readOnly: true,
                      controller: controller.dateTextController,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Date',
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
                  Navigator.pop(context);
                },
                child: const Text('BACK'),
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.green,
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.isEdit.isFalse
                        ? controller.saveRepositories(() {
                            reusableWidget.showLoader(context);
                          }, () {
                            Navigator.pop(context);
                            reusableWidget.hideLoader();
                            controller.getAllRepositories();
                            mySnackBar('Successfully Inserted',
                                const Icon(Icons.check));
                          }, () {
                            reusableWidget.hideLoader();
                          })
                        : controller.updateRepositories(id, () {
                            reusableWidget.showLoader(context);
                          }, () {
                            reusableWidget.hideLoader();
                            controller.getAllRepositories();
                            mySnackBar('Updated Successfully',
                                const Icon(Icons.check));
                            Navigator.pop(context);
                          }, () {
                            reusableWidget.hideLoader();
                            mySnackBar(
                                'Error Occured!', const Icon(Icons.warning));
                            Navigator.pop(context);
                          });
                  } else {
                    mySnackBar(
                      'Please fill all forms',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                  }
                },
                child: Obx(
                  () => controller.isEdit.isTrue
                      ? const Text('UPDATE')
                      : const Text('SAVE'),
                ),
              ),
            ],
          );
        });
  }

  openDeleteDialog(
      BuildContext context, RepositoriesController controller, int id) {
    showAdaptiveDialog(
        context: context,
        builder: (_) {
          return AlertDialog.adaptive(
            title: const Text('Delete Repository!!'),
            content: const Text('Are you sure?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('NO'),
              ),
              MaterialButton(
                onPressed: () {
                  controller.deleteRepositories(id, () {
                    reusableWidget.showLoader(context);
                  }, () {
                    mySnackBar(
                      'Successfully Deleted',
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    );
                    reusableWidget.hideLoader();
                    controller.getAllRepositories();
                    Navigator.pop(context);
                  }, () {
                    mySnackBar(
                      'Error Occured!!',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                    reusableWidget.hideLoader();
                  });
                },
                child: const Text('YES'),
              ),
            ],
          );
        });
  }

  pickDate(BuildContext context, RepositoriesController controller) async {
    try {
      var datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      var date = DateFormat('yyyy/MM/dd').format(datePicked!);
      controller.dateTextController.text = date;
    } catch (ex) {}
  }

  void downloadFile(String attachment) async {
    var url = '${Routes.BASE_URL}storage/$attachment';
    if (Platform.isIOS) {
      Directory ios = await getApplicationDocumentsDirectory();
      print(ios);
      String fullPath = '${ios.path}/$attachment';
    }
  }
}
