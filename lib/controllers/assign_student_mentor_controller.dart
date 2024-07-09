import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/faculty_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/student_mentor_model.dart';
import 'package:lms/models/student_model.dart';
import 'package:lms/services/assign_student_mentor_services.dart';

class AssignStudentMentorController extends GetxController {
  var isLoading = false.obs;
  AssignStudentMentorServices services = Get.find(tag: 'assignStudentServices');
  var programData = Rxn<SpecializationModel>();
  var batchData = Rxn<BatchModel>();
  var facultyData = Rxn<FacultyModel>();
  var facultyList = <FacultyModel>[].obs;
  var studentList = <StudentModel>[].obs;
  var studentMentorList = <StudentMentorModel>[].obs;
  var mentoredStudentsList = [].obs;
  var specialization_id = 0.obs;
  var program_id = 0.obs;
  var course_id = 0.obs;
  var batch_id = 0.obs;
  var faculty_id = 0.obs;
  var semester = ''.obs;
  var infoTextController = TextEditingController();
  @override
  void onInit() {
    getMentors();
    super.onInit();
  }

  void getMentors() async {
    isLoading.value = true;
    try {
      var response = await services.getAllFaculty();
      facultyList.addAll(response);
      isLoading.value = false;
    } catch (ex) {
      isLoading.value = false;
    }
  }

  Future getAllFaculty() async {
    var data = await services.getAllFaculty();
    return data;
  }

  Future getAllProgram() async {
    var data = await services.getAllProgram();
    return data;
  }

  Future getAllBatch() async {
    var data = await services.getBatch(course_id.value);
    return data;
  }

  void getMentorAllStudents(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    studentList.clear();
    try {
      var response = await services.getMentorAllStudents(
          specialization_id.value, batch_id.value);

      for (var data in response) {
        studentList.add(
          StudentModel(
            id: data['id'],
            batch_id: data['batch_id'],
            programme_id: data['programme_id'],
            specialization_id: data['specialization_id'],
            mzu_regn_no: data['mzu_regn_no'],
            full_name: data['profile']['name'],
            isSelected: data['student_mentor'].isEmpty ? false : true,
          ),
        );
      }
      onSuccess();
    } catch (ex) {
      onError();
      print(ex);
    }
  }

  void submitStudentMentor(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.submitStudentMentor(studentMentorList);
      if (response == 200) {
        onSuccess();
      }
    } catch (ex) {
      onError();
    }
  }

  void getStudentMentorList(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    mentoredStudentsList.clear();
    try {
      var response = await services.getStudentsMentor(id);
      mentoredStudentsList.addAll(response.data['data']);
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  void updateInfo(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.updateInfo(id, infoTextController.text);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
