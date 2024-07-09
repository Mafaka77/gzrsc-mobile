import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_marks_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/internal_exam_st_mark_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/services/internal_mark_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InternalMarkController extends GetxController {
  InternalMarkServices services = Get.find(tag: 'internalMarkServices');
  GetStorage storage = GetStorage();
  final formKey = GlobalKey<FormState>();
  var course_id = 0.obs;
  var program_id = 0.obs;
  var specialization_id = 0.obs;
  var batch_id = 0.obs;
  var subject_id = 0.obs;
  var internal_exam_id = 0.obs;
  var semester = ''.obs;
  var passMark = TextEditingController();
  var fullMark = TextEditingController();
  var programData = Rxn<SpecializationModel>();
  var batchData = Rxn<BatchModel>();
  var subjectData = Rxn<SubjectModel>();
  var internalExamData = Rxn<InternalExamModel>();
  var internalExamMarks = <InternalExamMarksModel>[].obs;
  var internalExamAllStudents = <InternalExamMarksModel>[].obs;
  var internalExamStudentMark = <InternalExamStudentMarkModel>[].obs;
  var subject = ''.obs;
  var program = ''.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  var limit = 0.obs;
  var allProgrammeList = [].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  //FILTER
  var filterByProgrammeId = 0.obs;
  var filterByBatchId = 0.obs;
  var filterByName = TextEditingController();
  var filterByRegNo = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    getAllStudents(() {});
    // getAllProgramme();
    super.onInit();
  }

  Future getAllProgram() async {
    var data = await services.getAllProgram();
    return data;
  }

  Future getAllBatch() async {
    var data = await services.getBatch(course_id.value);
    return data;
  }

  Future getAllSubject() async {
    var data = await services.getSubject(
        specialization_id.value, int.parse(semester.value));
    return data;
  }

  Future getAllInternalExam() async {
    var data = await services.getInternalExam();
    return data;
  }

  Future filterInternalExamMarks(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();

    try {
      var data = await services.filterInternalMarks(
          internal_exam_id.value,
          batch_id.value,
          subject_id.value,
          int.parse(semester.value),
          specialization_id.value);
      var marksData = data['data'];
      subject.value = data['subject']['name'];
      internalExamMarks.clear();
      internalExamAllStudents.clear();
      for (var d in marksData) {
        internalExamMarks.add(InternalExamMarksModel(
          student_id: d['id'],
          name: d['profile']['name'],
          batch_id: batch_id.value,
          subject_id: subject_id.value,
          semester: int.parse(semester.value),
          internal_exam_id: internal_exam_id.value,
          pass_mark: int.parse(passMark.text),
          full_mark: int.parse(fullMark.text),
          mark_obtain: d['internal_exam_mark'].isEmpty
              ? 0
              : d['internal_exam_mark'][0]['mark_obtain'],
          mzu_regn_no: d['mzu_regn_no'] ?? '',
          entry_by: storage.read('user_id'),
        ));
      }
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  Future submitInternalExamMarks(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.submitInternalExamMarks(internalExamMarks);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  void getAllStudents(Function onSuccess) async {
    isLoading.value = true;
    try {
      offset.value = 0;
      limit.value = 40;
      internalExamAllStudents.clear();
      var response = await services.getAllStudents(
          offset.value,
          limit.value,
          filterByProgrammeId.value,
          filterByBatchId.value,
          filterByName.text,
          filterByRegNo.text);
      var data = response['student'];
      for (var d in data) {
        internalExamAllStudents.add(
          InternalExamMarksModel(
            name: d['profile']['name'],
            student_id: d['id'],
            mzu_regn_no: d['mzu_regn_no'],
            semester: d['batch']['current_semester'],
            programme_code: d['programme']['code'],
            specialization: d['specialization']['name'],
            noOfSemester: d['programme']['semester'],
            pass_mark: d['pass_mark'],
            full_mark: d['full_mark'],
            mark_obtain: d['mark_obtain'],
            entry_by: storage.read('user_id'),
          ),
        );
      }
      refreshController.refreshCompleted();
      isLoading.value = false;
      onSuccess;
    } catch (ex) {
      refreshController.refreshFailed();
      isLoading.value = false;
    }
  }

  void loadMore() async {
    offset.value = internalExamAllStudents.length;
    try {
      var response = await services.getAllStudents(
        offset.value,
        limit.value,
        filterByProgrammeId.value,
        filterByBatchId.value,
        filterByName.text,
        filterByRegNo.text,
      );
      var data = response['student'];
      for (var d in data) {
        internalExamAllStudents.add(
          InternalExamMarksModel(
            name: d['profile']['name'],
            student_id: d['id'],
            mzu_regn_no: d['mzu_regn_no'],
            semester: d['batch']['current_semester'],
            programme_code: d['programme']['code'],
            specialization: d['specialization']['name'],
            noOfSemester: d['programme']['semester'],
            pass_mark: d['pass_mark'],
            full_mark: d['full_mark'],
            mark_obtain: d['mark_obtain'],
            entry_by: storage.read('user_id'),
          ),
        );
      }
      refreshController.loadComplete();
    } catch (ex) {
      refreshController.loadFailed();
    }
  }

  // void getAllProgramme() async {
  //   try {
  //     var response = await services.getAllProgramme();
  //     allProgrammeList.addAll(response);
  //     print(allProgrammeList);
  //   } catch (ex) {}
  // }

  Future getInternalMarkBySId(
    int studentId,
    Function onLoading,
    Function onSuccess,
    Function onError,
  ) async {
    onLoading();
    try {
      var response = await services.getInternalMarksBySId(studentId);
      var data = response['data'];
      internalExamStudentMark.clear();
      for (var d in data) {
        internalExamStudentMark.add(
          InternalExamStudentMarkModel(
            internal_exam_id: d['internal_exam_id'],
            student_id: d['student_id'],
            semester: d['semester'],
            pass_mark: d['pass_mark'],
            full_mark: d['full_mark'],
            mark_obtain: d['mark_obtain'],
            subject_name: d['subject']['name'],
            subject_code: d['subject']['code'],
            internal_name: d['internal_exam']['name'],
          ),
        );
      }
      print(internalExamStudentMark);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future getAllBatchFilter() async {
    try {
      var response = await services.getAllBatchFilter();
      return response;
    } catch (ex) {}
  }
}
