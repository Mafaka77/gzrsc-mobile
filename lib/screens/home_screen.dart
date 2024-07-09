import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/home_controller.dart';
import 'package:lms/widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(
                        Icons.line_style_outlined,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              drawer: DrawerWidget(),
              body: Obx(
                () =>
                    controller.widgetOptions[controller.selectedIndex.toInt()],
              ));
        });
  }
}
