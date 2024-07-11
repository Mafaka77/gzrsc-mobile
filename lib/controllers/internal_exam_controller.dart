import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/services/internal_exam_services.dart';
import 'package:lms/snackbar_widget.dart';

class InternalExamController extends GetxController {
  InternalExamServices services = Get.find(tag: 'internalExamServices');
  final formKey = GlobalKey<FormState>();
  var onLoading = false.obs;
  var internalExamList = <InternalExamModel>[].obs;
  var status = 'active'.obs;
  var internalName = TextEditingController();
  var internalCode = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    getAllInternalExam();
    super.onInit();
  }

  void getAllInternalExam() async {
    onLoading.value = true;
    try {
      var response = await services.getAllInternals();
      internalExamList.addAll(response);
      onLoading.value = false;
    } catch (ex) {
      onLoading.value = false;
    }
  }

  Future addInternalExam(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();

    try {
      var response = await services.addInternalExam(
          id, internalName.text, internalCode.text, status.value);
      internalExamList.clear();
      internalExamList.addAll(response);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future deleteInternalExam(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();

    try {
      var response = await services.deleteInternalExam(id);
      internalExamList.clear();
      internalExamList.addAll(response);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
