import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/repository_category_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class RepositoryCategoryScreen extends StatelessWidget {
  RepositoryCategoryScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RepositoryCategoryController>(
        init: RepositoryCategoryController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.isEdit.value = false;
                openAddDialog(0, context, controller);
                controller.categoryTextController.clear();
                controller.update();
              },
              child: const Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('LIST OF REPOSITORY CATEGORIES'),
                    sizedBox(20),
                    Obx(() => controller.isLoading.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.repositoryCategoryList.isEmpty
                            ? const Center(
                                child: Text('No Data'),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    sizedBox(10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.repositoryCategoryList.length,
                                itemBuilder: (c, i) {
                                  var data =
                                      controller.repositoryCategoryList[i];
                                  return ListTile(
                                    onTap: () {
                                      controller.isEdit.value = true;
                                      controller.categoryTextController.text =
                                          data.name!;
                                      controller.status.value = data.status!;
                                      controller.update();
                                      openAddDialog(
                                          data.id!, context, controller);
                                    },
                                    tileColor: Colors.white,
                                    dense: true,
                                    title: Text(data.name!),
                                    subtitle: Text(
                                      data.status!,
                                      style: TextStyle(
                                          color: data.status == 'active'
                                              ? Colors.green
                                              : Colors.red),
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
                                }))
                  ],
                ),
              ),
            ),
          );
        });
  }

  openDeleteDialog(
      BuildContext context, RepositoryCategoryController controller, int id) {
    showAdaptiveDialog(
        context: context,
        builder: (_) {
          return AlertDialog.adaptive(
            title: const Text('Are you sure?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () {
                  controller.deleteRepositoryCategory(id, () {
                    reusableWidget.showLoader(context);
                  }, () {
                    mySnackBar(
                      'Successfully Deleted',
                      const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    );
                    Navigator.pop(context);
                    reusableWidget.hideLoader();
                    controller.getRepositoryCategories();
                  }, () {
                    mySnackBar(
                      'Error Occured!! Try again',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                    reusableWidget.hideLoader();
                  });
                },
                child: const Text('Yes'),
              )
            ],
          );
        });
  }

  openAddDialog(
      int id, BuildContext context, RepositoryCategoryController controller) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              height: Get.height * 0.4,
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ADD REPOSITORY CATEGORY'),
                    sizedBox(10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                      controller: controller.categoryTextController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Name',
                        border: OutlineInputBorder(),
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
                child: const Text('CLOSE'),
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.blue,
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.isEdit.isFalse
                        ? controller.saveRepositoryCategory(() {
                            reusableWidget.showLoader(context);
                          }, () {
                            mySnackBar(
                              'Successfully Inserted',
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            );
                            reusableWidget.hideLoader();
                            controller.getRepositoryCategories();
                            Navigator.pop(context);
                          }, () {
                            mySnackBar(
                                'Error Occured',
                                const Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ));
                            reusableWidget.hideLoader();
                          })
                        : controller.updateRepositoryCategory(id, () {
                            reusableWidget.showLoader(context);
                          }, () {
                            mySnackBar(
                              'Updated Successfully',
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            );
                            reusableWidget.hideLoader();
                            Navigator.pop(context);
                            controller.getRepositoryCategories();
                          }, () {
                            reusableWidget.hideLoader();
                          });
                  }
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }
}
