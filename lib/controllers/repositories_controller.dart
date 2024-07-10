import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/repositories_model.dart';
import 'package:lms/models/repository_category_model.dart';
import 'package:lms/services/repository_services.dart';

class RepositoriesController extends GetxController {
  RepositoryServices services = Get.find(tag: 'repositoryServices');
  var formKey = GlobalKey<FormState>();
  var respositoriesList = <RepositoriesModel>[].obs;
  var categoryData = Rxn<RepositoryCategoryModel>();
  var categoryId = 0.obs;
  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var attachmentController = TextEditingController();
  File? attachmentFile = File('');
  var isAttachmentPicked = false.obs;
  var dateTextController = TextEditingController();
  var isLoading = false.obs;
  var submittedBy = 0.obs;
  var isEdit = false.obs;
  var status = 'active'.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getAllRepositories();
    getMyProfile();
    super.onInit();
  }

  void getMyProfile() async {
    try {
      var response = await services.getMyProfile();
      submittedBy.value = response['id'];
    } catch (ex) {}
  }

  void getAllRepositories() async {
    respositoriesList.clear();
    isLoading.value = true;
    try {
      var response = await services.getAllRepositories();
      respositoriesList.addAll(response);
      isLoading.value = false;
    } catch (ex) {
      isLoading.value = false;
    }
  }

  Future getAllCategories() async {
    try {
      var response = await services.getAllCategories();
      return response;
    } catch (ex) {}
  }

  void saveRepositories(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.saveRepositories(
        categoryId.value,
        titleTextController.text,
        descriptionTextController.text,
        attachmentFile,
        dateTextController.text,
        attachmentController.text,
        submittedBy.value,
      );
      if (response == 200) {
        onSuccess();
      } else {
        onError();
      }
    } catch (ex) {
      onError();
    }
  }

  void deleteRepositories(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.deleteRepositories(id);
      if (response == 200) {
        onSuccess();
      } else {
        onError();
      }
    } catch (ex) {
      onError();
    }
  }

  void updateRepositories(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    try {} catch (ex) {}
  }

  void clearForm() {
    titleTextController.clear();
    descriptionTextController.clear();
    dateTextController.clear();
    attachmentFile = File('');
    attachmentController.clear();
    categoryId.value = 0;
    categoryData.value = null;
  }
}
