import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/repository_category_model.dart';
import 'package:lms/services/repository_services.dart';
import 'package:lms/snackbar_widget.dart';

class RepositoryCategoryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RepositoryServices services = Get.find(tag: 'repositoryServices');
  var repositoryCategoryList = <RepositoryCategoryModel>[].obs;
  var isLoading = false.obs;
  var categoryTextController = TextEditingController();
  var status = 'active'.obs;
  var isEdit = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getRepositoryCategories();
    super.onInit();
  }

  void getRepositoryCategories() async {
    isLoading.value = true;
    repositoryCategoryList.clear();
    try {
      var response = await services.getAllRepositoryCategories();
      repositoryCategoryList.addAll(response);
      isLoading.value = false;
    } catch (ex) {
      print(ex);
      isLoading.value = false;
      mySnackBar(
          'Error Occured',
          const Icon(
            Icons.warning,
            color: Colors.red,
          ));
    }
  }

  void deleteRepositoryCategory(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.deleteRepositoryCategories(id);
      if (response == 200) {
        onSuccess();
      } else {
        onError();
      }
    } catch (ex) {
      onError();
    }
  }

  void saveRepositoryCategory(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response =
          await services.saveRepositoryCategories(categoryTextController.text);
      if (response == 200) {
        onSuccess();
      } else {
        onError();
      }
    } catch (ex) {
      onError();
    }
  }

  void updateRepositoryCategory(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.updateRepositoryCategories(
          id, categoryTextController.text, status.value);
      if (response == 200) {
        onSuccess();
      } else {
        onError();
      }
    } catch (ex) {
      onError();
    }
  }
}
