import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/controllers/home_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class DrawerWidget extends GetView<HomeController> {
  DrawerWidget({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  GetStorage storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.lime,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome, '),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => controller.isLoading.isTrue
                          ? const CircularProgressIndicator()
                          : Text(controller.userData.first.name!)),
                      sizedBox(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.person),
                              label: const Text('My Profile')),
                          TextButton.icon(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                              ),
                              onPressed: () async {
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog.adaptive(
                                        title: const Text('Logout'),
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
                                              controller.logout(() {
                                                reusableWidget
                                                    .showLoader(context);
                                              }, () async {
                                                reusableWidget.hideLoader();
                                                Get.offAllNamed(
                                                    '/login-screen');
                                                await storage.erase();
                                              }, () {
                                                reusableWidget.hideLoader();
                                              });
                                            },
                                            child: const Text('YES'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.logout),
                              label: const Text('Logout')),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => ListTile(
              title: const Text('Home'),
              selected: controller.selectedIndex == 0,
              onTap: () {
                onItemTapped(0);
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            children: [
              ExpansionTile(
                title: const Text('Examination'),
                children: [
                  Obx(
                    () => ListTile(
                      title: const Text('Add Internal Exam'),
                      selected: controller.selectedIndex.value == 1,
                      onTap: () {
                        onItemTapped(1);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      title: const Text('Attendances'),
                      selected: controller.selectedIndex.value == 2,
                      onTap: () {
                        onItemTapped(2);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      title: const Text('Internal Exam Mark'),
                      selected: controller.selectedIndex.value == 3,
                      onTap: () {
                        onItemTapped(3);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      title: const Text('Semester Exam Fees'),
                      selected: controller.selectedIndex.value == 4,
                      onTap: () {
                        onItemTapped(4);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      title: const Text('Semester Exam Score'),
                      selected: controller.selectedIndex.value == 5,
                      onTap: () {
                        onItemTapped(5);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Mentoring'),
                children: [
                  ListTile(
                    title: const Text('Assign Student-Mentor'),
                    selected: controller.selectedIndex.value == 6,
                    onTap: () {
                      onItemTapped(6);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              ExpansionTile(
                title: const Text('Activity Repositories'),
                children: [
                  ListTile(
                    title: const Text('Repository Category'),
                    selected: controller.selectedIndex.value == 7,
                    onTap: () {
                      onItemTapped(7);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Repositories'),
                    selected: controller.selectedIndex.value == 8,
                    onTap: () {
                      onItemTapped(8);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              // ExpansionTile(
              //   title: const Text('Post'),
              //   children: [
              //     ListTile(
              //       title: const Text('Post Category'),
              //       selected: controller.selectedIndex.value == 9,
              //       onTap: () {
              //         onItemTapped(9);
              //         Navigator.pop(context);
              //       },
              //     ),
              //     ListTile(
              //       title: const Text('Post'),
              //       selected: controller.selectedIndex.value == 10,
              //       onTap: () {
              //         onItemTapped(10);
              //         Navigator.pop(context);
              //       },
              //     )
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    controller.selectedIndex.value = index;
  }
}
