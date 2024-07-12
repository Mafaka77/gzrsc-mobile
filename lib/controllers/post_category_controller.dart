import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/services/post_services.dart';

class PostCategoryController extends GetxController {
  PostServices services = Get.find(tag: 'postServices');
  var nameTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var postCategoryList = [].obs;
  var isLoading = false.obs;
  var isEdit = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    // getAllPostCategory();
    super.onInit();
  }

  void getAllPostCategory() async {
    try {
      var response = await services.getAllPostCategory();
    } catch (ex) {}
  }
}
