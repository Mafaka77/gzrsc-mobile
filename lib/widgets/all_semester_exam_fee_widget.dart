import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/semester_exam_fee_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllSemesterExamFeeWidget extends GetView<SemesterExamFeeController> {
  AllSemesterExamFeeWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LIST OF SEMESTER EXAM FEES'),
          sizedBox(20),
          SizedBox(
            height: Get.height * 0.9,
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
                controller.getSemesterExamFee();
              },
              onLoading: () {
                controller.loadMore();
              },
              child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.semesterExamFeeList.length,
                  itemBuilder: (c, i) {
                    var data = controller.semesterExamFeeList[i];
                    return Card(
                      color: Colors.white,
                      elevation: 0,
                      child: ListTile(
                        dense: true,
                        title: Text(
                            '${data.programModel!.code}-${data.programModel!.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                const Text('Semester: '),
                                Text(
                                  '${data.semester}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('Subject: '),
                                Text(
                                  '${data.subjectModel!.name}- ${data.subjectModel!.code}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('Amount(Rs.): '),
                                Text(
                                  data.amount == null
                                      ? '0'
                                      : data.amount.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('Year: '),
                                Text(
                                  data.year.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('Status: '),
                                Text(
                                  data.status == 'active'
                                      ? 'Active'
                                      : 'Inactive',
                                  style: TextStyle(
                                      color: data.status == 'active'
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {
                                openEditDialog(context, data.id, data.amount!);
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
                                              Get.back();
                                            },
                                            child: const Text('No'),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              controller.deleteSemesterExamFee(
                                                  data.id!, () {
                                                reusableWidget
                                                    .showLoader(context);
                                              }, () {
                                                Navigator.pop(context);
                                                reusableWidget.hideLoader();
                                                mySnackBar(
                                                  'Deleted Successfully',
                                                  const Icon(
                                                    Icons.check,
                                                    color: Colors.blue,
                                                  ),
                                                );
                                              }, () {
                                                reusableWidget.hideLoader();
                                                mySnackBar(
                                                  'Error Occured',
                                                  const Icon(
                                                    Icons.warning,
                                                    color: Colors.red,
                                                  ),
                                                );
                                              });
                                            },
                                            child: const Text('CONFIRM'),
                                          )
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

  void openEditDialog(
    BuildContext context,
    int? id,
    String amount,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SizedBox(
              height: Get.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('UPDATE AMOUNT'),
                  TextFormField(
                    controller: TextEditingController(text: amount),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      amount = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CLEAR'),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  controller.updateAmount(id!, amount, () {
                    reusableWidget.showLoader(context);
                  }, () {
                    Navigator.pop(context);
                    reusableWidget.hideLoader();
                    mySnackBar(
                        'Updated Successfully',
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
                child: const Text('UPDATE'),
              ),
            ],
          );
        });
  }
}
