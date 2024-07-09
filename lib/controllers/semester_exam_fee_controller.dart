import 'dart:ffi';

import 'package:get/get.dart';
import 'package:lms/models/semester_exam_fee_model.dart';
import 'package:lms/models/semester_subject_exam_fee_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/services/semester_exam_fee_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SemesterExamFeeController extends GetxController {
  SemesterExamFeeServices services = Get.find(tag: 'semesterExamFeeServices');
  var onLoading = false.obs;
  var semesterExamFeeList = <SemesterExamFeeModel>[].obs;
  var semesterSubjectFeeList = <SemesterSubjectExamFeeModel>[].obs;
  var programData = Rxn<SpecializationModel>();
  var programme_id = 0.obs;
  var specialization_id = 0.obs;
  var semester = ''.obs;
  var offset = 0.obs;
  var limit = 15.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void onInit() {
    getSemesterExamFee();
    // TODO: implement onInit
    super.onInit();
  }

  Future getSemesterExamFee() async {
    onLoading.value = true;
    offset.value = 0;
    limit.value = 15;
    try {
      var response =
          await services.getAllSemesterFee(offset.value, limit.value);
      semesterExamFeeList.clear();
      semesterSubjectFeeList.clear();
      semesterExamFeeList.addAll(response);
      onLoading.value = false;
      refreshController.refreshCompleted();
    } catch (ex) {
      onLoading.value = false;
    }
  }

  Future loadMore() async {
    offset.value = semesterExamFeeList.length;
    try {
      var response =
          await services.getAllSemesterFee(offset.value, limit.value);
      semesterSubjectFeeList.clear();
      semesterExamFeeList.addAll(response);
      refreshController.loadComplete();
    } catch (ex) {}
  }

  Future getAllProgram() async {
    var data = await services.getAllProgram();
    return data;
  }

  Future filterSemesterExamFee(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.filterSemesterExamFee(programme_id.value,
          specialization_id.value, int.parse(semester.value));
      semesterExamFeeList.clear();
      semesterSubjectFeeList.clear();
      for (var da in response) {
        semesterSubjectFeeList.add(
          SemesterSubjectExamFeeModel(
            id: da['id'],
            programme_id: da['programme_id'],
            programme_name: da['programme']['name'],
            programme_code: da['programme']['code'],
            name: da['name'],
            code: da['code'],
            semester: da['semester'],
            specialization_id: da['specialization_id'],
            specialization_name: da['specialization']['name'],
            amount: da['semester_exam_fee'].isEmpty
                ? ''
                : da['semester_exam_fee'][0]['amount'],
            sId: da['semester_exam_fee'].isEmpty
                ? 0
                : da['semester_exam_fee'][0]['id'],
          ),
        );
      }
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  Future saveSemesterExamFee(
      Function onLoading, Function onSuccess, Function onError) async {
    try {
      var response = await services.saveSemesterExamFee(semesterSubjectFeeList);
      print(semesterSubjectFeeList);
    } catch (ex) {}
  }

  Future deleteSemesterExamFee(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.deleteSemesterExamFee(id);
      semesterExamFeeList.clear();
      semesterSubjectFeeList.clear();
      semesterExamFeeList.addAll(response);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future updateAmount(int id, String amount, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.updateAmount(id, amount);
      semesterExamFeeList.clear();
      semesterSubjectFeeList.clear();
      semesterExamFeeList.addAll(response);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
