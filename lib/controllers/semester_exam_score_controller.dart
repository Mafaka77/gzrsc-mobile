import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/semester_exam_model.dart';
import 'package:lms/models/semester_subject_score_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/student_model.dart';
import 'package:lms/services/semester_exam_score_services.dart';

class SemesterExamScoreController extends GetxController
    with GetTickerProviderStateMixin {
  SemesterExamScoreServices services =
      Get.find(tag: 'semesterExamScoreServices');
  GetStorage storage = GetStorage();
  var programData = Rxn<SpecializationModel>();
  var programme_id = 0.obs;
  var specialization_id = 0.obs;
  var semester = ''.obs;
  var batchData = Rxn<BatchModel>();
  var batch_id = 0.obs;
  var semesterExamScoreList = <StudentModel>[].obs;
  var semesterSubjectScoreList = <SemesterSubjectScoreModel>[].obs;
  var semesterExamMarkList = <SemesterExamModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future getAllProgram() async {
    var data = await services.getAllProgram();
    return data;
  }

  Future getAllBatch() async {
    var data = await services.getAllBatch();
    return data;
  }

  Future getSemesterExamScore(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    semesterExamScoreList.clear();
    try {
      var response = await services.getSemesterExamScore(batch_id.value,
          programme_id.value, specialization_id.value, semester.value);
      for (var data in response) {
        semesterExamScoreList.add(
          StudentModel(
              id: data['id'],
              batch_id: data['batch_id'],
              programme_id: data['programme_id'],
              specialization_id: data['specialization_id'],
              mzu_regn_no: data['mzu_regn_no'],
              full_name: data['profile']['name'],
              current_semester: data['batch']['current_semester'],
              start_year: data['batch']['start_year'],
              end_year: data['batch']['end_year'],
              programme_code: data['programme']['code'],
              programme_name: data['programme']['name'],
              specialization_name: data['specialization']['name'],
              programme_semester: data['programme']['semester']),
        );
      }
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future getSubjectBasedOnId(
      int batchId,
      int studentId,
      int semester,
      int specializationId,
      int programmeId,
      Function onLoading,
      Function onSuccess,
      Function onError) async {
    onLoading();
    semesterSubjectScoreList.clear();

    try {
      var response = await services.getSubjectBasedOnId(
          studentId, semester, specializationId, programmeId);
      var score = response['score'];
      var subject = response['data'];

      for (var data in subject) {
        semesterSubjectScoreList.add(
          SemesterSubjectScoreModel(
            id: data['id'],
            department_id: data['department_id'],
            programme_id: data['programme_id'],
            specialization_id: data['specialization_id'],
            name: data['name'],
            code: data['code'],
            semester: data['semester'],
            credit: data['credit'],
            score: data['semester_exam'].isEmpty
                ? ''
                : data['semester_exam'][0]['score'],
            student_id: studentId,
            subject_id: data['id'],
            entry_by: storage.read('user_id'),
            batch_id: batchId,
            semester_exam_id: data['semester_exam'].isEmpty
                ? 0
                : data['semester_exam'][0]['id'],
          ),
        );
        // }
      }
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  Future saveSemesterGrade(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.saveSemesterGrade(semesterSubjectScoreList);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future getSemesterMarkDetails(int studentId, int semester, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    semesterExamMarkList.clear();
    try {
      var response = await services.getSemesterMarkDetails(studentId, semester);
      for (var data in response) {
        print(data['score']);
        semesterExamMarkList.add(
          SemesterExamModel(
            id: data['id'],
            student_id: data['student_id'],
            batch_id: data['batch_id'],
            semester: data['semester'],
            subject_id: data['subject_id'],
            score: data['score'],
            subject_name: data['subject']['name'],
            subject_code: data['subject']['code'],
          ),
        );
      }

      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
