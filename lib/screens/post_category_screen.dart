import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/post_category_controller.dart';
import 'package:lms/reusable_widget.dart';

class PostCategoryScreen extends StatelessWidget {
  PostCategoryScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostCategoryController>(
        init: PostCategoryController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                openAddDialog(context, controller);
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  openAddDialog(BuildContext context, PostCategoryController controller) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('POST CATEGORY'),
            content: SizedBox(
              height: Get.height * 0.3,
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameTextController,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {},
                child: const Text('RESET'),
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.blue,
                onPressed: () {},
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }
}
