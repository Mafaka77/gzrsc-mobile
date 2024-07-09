import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/internal_mark_controller.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/screens/internal_exam_mark_detail_screen.dart';
import 'package:lms/widgets/sizedbox_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InternalMarkAllStudentWidget extends GetView<InternalMarkController> {
  InternalMarkAllStudentWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  openFilter(context);
                },
                icon: const Icon(Icons.sort),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.8,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const ClassicHeader(
                completeText: 'Finished',
                refreshingIcon: CupertinoActivityIndicator(),
              ),
              footer: CustomFooter(builder: (c, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator(
                    color: Colors.white,
                  );
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("Release to load more");
                } else {
                  body = const Text("No more Data");
                }
                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 30.0,
                  child: Center(child: body),
                );
              }),
              controller: controller.refreshController,
              onRefresh: () {
                controller.getAllStudents(() {});
              },
              onLoading: () {
                controller.loadMore();
              },
              child: Obx(
                () => controller.isLoading.isTrue
                    ? const CircularProgressIndicator()
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 4,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.internalExamAllStudents.length,
                        itemBuilder: (c, i) {
                          var data = controller.internalExamAllStudents[i];
                          return ListTile(
                            onTap: () {
                              controller.getInternalMarkBySId(
                                  int.parse(data.student_id.toString()), () {
                                reusableWidget.showLoader(context);
                              }, () {
                                Get.to(
                                  () => InternalExamMarkDetailScreen(),
                                  arguments: [
                                    data.student_id,
                                    data.internal_exam_id,
                                    data.noOfSemester,
                                    data.semester,
                                  ],
                                );
                                reusableWidget.hideLoader();
                              }, () {
                                reusableWidget.hideLoader();
                              });
                            },
                            tileColor: Colors.white,
                            dense: true,
                            title: Wrap(
                              children: [
                                Text(data.name!),
                                Text(' (${data.mzu_regn_no ?? ''})')
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(data.programme_code!),
                                const Text('-'),
                                Text(data.specialization!),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openFilter(BuildContext context) async {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            content: SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filter'),
                  DropdownSearch<SpecializationModel>(
                    selectedItem: controller.programData.value,
                    asyncItems: (text) async {
                      var data = await controller.getAllProgram();
                      // print(data);
                      return data;
                    },
                    onChanged: (value) {
                      controller.course_id.value =
                          value!.programModel.course_id!;
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
                        var data = await controller.getAllBatchFilter();
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
                  TextFormField(
                    controller: controller.filterByName,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      labelText: 'Filter By Name',
                    ),
                  ),
                  sizedBox(10),
                  TextFormField(
                    controller: controller.filterByRegNo,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      labelText: 'Filter By Regn. No',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller.filterByBatchId.value = 0;
                      controller.filterByProgrammeId.value = 0;
                      controller.filterByName.clear();
                      controller.filterByRegNo.clear();
                      controller.getAllStudents(() {});
                      Navigator.pop(context);
                    },
                    child: const Text('CLEAR'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.blue,
                    onPressed: () {
                      controller.getAllStudents(() {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'FILTER',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          );
        });
  }
}
