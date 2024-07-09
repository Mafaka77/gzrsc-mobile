import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/controllers/attendance_controller.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/month_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllAttendanceWidget extends GetView<AttendanceController> {
  AllAttendanceWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Attendance List'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  openFilterDialog(context);
                },
                icon: const Icon(Icons.sort),
              ),
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
                controller.getAllAttendance();
              },
              onLoading: () {
                controller.loadMore();
              },
              child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.allAttendanceList.length,
                  itemBuilder: (c, i) {
                    var data = controller.allAttendanceList[i];
                    var date = DateTime.parse(data.month_year!);
                    return Card(
                      elevation: 0,
                      child: ListTile(
                        dense: true,
                        title: Text(data.student_name!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                const Text(
                                  'Attendance: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '${int.parse(data.attendance!.toStringAsFixed(0))}/${double.parse(data.total!).toStringAsFixed(0)}')
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  'Subject: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(data.subject_name!)
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  'Programme: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '${data.programme_code!} - ${data.specialization_name!}')
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  'Month-Year: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(DateFormat('MMM,y').format(date))
                              ],
                            ),
                          ],
                        ),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {
                                var month = DateFormat('MMMM').format(
                                    DateTime.parse(data.month_year.toString()));
                                var monthNo = DateFormat('M').format(
                                    DateTime.parse(data.month_year.toString()));
                                var year = DateFormat('yyyy').format(
                                    DateTime.parse(data.month_year.toString()));
                                controller.monthData.value =
                                    MonthModel(month: month);
                                controller.month.value = int.parse(monthNo);
                                controller.year.value = year;
                                openEditDialog(
                                    context, data.id, data.attendance);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
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
                                              controller.deleteAttendance(
                                                  data.id!, () {
                                                reusableWidget
                                                    .showLoader(context);
                                              }, () {
                                                Navigator.pop(context);
                                                reusableWidget.hideLoader();
                                                mySnackBar(
                                                    'Successfully Deleted!',
                                                    const Icon(
                                                      Icons.check,
                                                      color: Colors.blue,
                                                    ));
                                              }, () {
                                                reusableWidget.hideLoader();
                                                mySnackBar(
                                                    'Error Occured!',
                                                    const Icon(
                                                      Icons.warning,
                                                      color: Colors.red,
                                                    ));
                                              });
                                            },
                                            child: const Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  void openEditDialog(BuildContext context, int? id, int? attendance) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              children: [
                TextFormField(
                  controller:
                      TextEditingController(text: attendance.toString()),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    attendance = int.parse(value);
                  },
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
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () {},
                child: const Text('CLEAR'),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  controller.updateAttendance(id!, attendance!, () {
                    reusableWidget.showLoader(context);
                  }, () {
                    reusableWidget.hideLoader();
                    mySnackBar(
                        'Successfully Updated',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    Navigator.pop(context);
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
                child: const Text('UPDATE'),
              ),
            ],
          );
        });
  }

  void openFilterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              children: [
                DropdownSearch<SpecializationModel>(
                  selectedItem: controller.programData.value,
                  asyncItems: (text) async {
                    var data = await controller.getAllProgram();
                    // print(data);
                    return data;
                  },
                  onChanged: (value) {
                    controller.filterByProgrammeId.value = value!.id!;
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
                      controller.filterByBatchId.value = value!.id!;
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
                    border: OutlineInputBorder(),
                    isDense: true,
                    labelText: 'Filter By Name',
                  ),
                ),
                sizedBox(10),
                TextFormField(
                  controller: controller.filterByRegnNo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    labelText: 'Filter By Regn. No',
                  ),
                )
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  controller.getAllAttendance();
                  Navigator.pop(context);
                },
                child: const Text('CLEAR'),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  controller.filterAttendances(() {
                    reusableWidget.showLoader(context);
                  }, () {
                    reusableWidget.hideLoader();
                    Navigator.pop(context);
                  }, () {
                    reusableWidget.hideLoader();
                    Navigator.pop(context);
                  });
                },
                child: const Text('FILTER'),
              ),
            ],
          );
        });
  }
}
