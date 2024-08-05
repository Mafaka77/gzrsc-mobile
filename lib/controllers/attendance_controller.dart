import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/models/all_attendance_model.dart';
import 'package:lms/models/attendance_model.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/month_model.dart';
import 'package:lms/models/program_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/services/attendance_services.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttendanceController extends GetxController {
  AttendanceServices services = Get.find(tag: 'attendanceServices');
  var expansionState = true.obs;
  final formKey = GlobalKey<FormState>();
  var expansionController = ExpansionTileController();
  var course_id = 0.obs;
  var program_id = 0.obs;
  var specialization_id = 0.obs;
  var batch_id = 0.obs;
  var subject_id = 0.obs;
  var subject_name = ''.obs;
  var internal_exam_id = 0.obs;
  var semester = ''.obs;
  var month = 0.obs;
  var monthDisplay = ''.obs;
  var year = ''.obs;
  var noOfClass = TextEditingController();
  var programData = Rxn<SpecializationModel>();
  var batchData = Rxn<BatchModel>();
  var subjectData = Rxn<SubjectModel>();
  var internalExamData = Rxn<InternalExamModel>();
  var monthData = Rxn<MonthModel>();
  var attendanceList = false.obs;
  var offset = 0.obs;
  var limit = 15.obs;
  var allAttendanceList = <AllAttendanceModel>[].obs;
  var isLoading = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var filterByProgrammeId = 0.obs;
  var filterByBatchId = 0.obs;
  var filterByName = TextEditingController();
  var filterByRegnNo = TextEditingController();
  List months = [
    {'id': 1, 'month': 'January'},
    {'id': 2, 'month': 'February'},
    {'id': 3, 'month': 'March'},
    {'id': 4, 'month': 'April'},
    {'id': 5, 'month': 'May'},
    {'id': 6, 'month': 'June'},
    {'id': 7, 'month': 'July'},
    {'id': 8, 'month': 'August'},
    {'id': 9, 'month': 'September'},
    {'id': 10, 'month': 'October'},
    {'id': 11, 'month': 'November'},
    {'id': 12, 'month': 'December'},
  ];
  List<String> yearList = [];
  var studentAttendance = <AttendanceModel>[].obs;
  var studentList = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getAllAttendance();
    getYear();
    super.onInit();
  }

  Future getMonth() async {
    var data = MonthModel.fromJsonList(months);
    return data;
  }

  void getYear() {
    String year;
    var date = DateTime.now();
    var d = DateFormat('y').format(date);
    int da = int.parse(d);
    for (int i = 2023; i <= da; i++) {
      yearList.add(i.toString());
    }
  }

  Future getAllProgram() async {
    var data = await services.getAllProgram();
    return data;
  }

  Future getBatch() async {
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

  Future filterAttendance(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.filterAttendance(
          subject_id.toInt(),
          batch_id.toInt(),
          internal_exam_id.toInt(),
          specialization_id.toInt(),
          month.toInt(),
          year.toString(),
          semester.toString());
      studentList.clear();
      studentAttendance.clear();
      // studentList.addAll(data);
      for (var d in data) {
        studentAttendance.add(
          AttendanceModel(
              student_id: d['id'],
              subject_id: subject_id.toInt(),
              batch_id: batch_id.toInt(),
              internal_exam_id: internal_exam_id.toInt(),
              month: month.toString(),
              year: year.toString(),
              semester: semester.value,
              attendance: d['attendance'].isEmpty
                  ? 0
                  : d['attendance'][0]['attendance'],
              mzu_regn_no: d['mzu_regn_no'],
              total: int.parse(noOfClass.text),
              name: d['profile']['name']),
        );
        // for (var a in d['attendance']) {}
      }

      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  void getAllAttendance() async {
    isLoading.value = true;
    try {
      var reponse = await services.getAllAttendance(offset.value, limit.value);
      allAttendanceList.clear();
      for (var data in reponse) {
        allAttendanceList.add(AllAttendanceModel(
            id: data['id'],
            internal_exam_id: data['internal_exam_id'],
            student_id: data['student_id'],
            semester: data['semester'],
            subject_id: data['subject_id'],
            attendance: data['attendance'],
            total: data['total'],
            month_year: data['month_year'],
            status: data['status'],
            entry_by: data['entry_by'],
            student_name: data['student']['profile']['name'],
            mzu_regn_no: data['student']['mzu_regn_no'],
            subject_name: data['subject']['name'],
            subject_code: data['subject']['code'],
            programme_name: data['subject']['programme']['name'],
            programme_code: data['subject']['programme']['code'],
            specialization_name: data['subject']['specialization']['name']));
      }
      refreshController.refreshCompleted();
      isLoading.value = false;
    } catch (ex) {
      print(ex);
      isLoading.value = false;
    }
  }

  Future loadMore() async {
    offset.value = allAttendanceList.length;
    try {
      var reponse = await services.getAllAttendance(offset.value, limit.value);
      for (var data in reponse) {
        allAttendanceList.add(AllAttendanceModel(
            id: data['id'],
            internal_exam_id: data['internal_exam_id'],
            student_id: data['student_id'],
            semester: data['semester'],
            subject_id: data['subject_id'],
            attendance: data['attendance'],
            total: data['total'],
            month_year: data['month_year'],
            status: data['status'],
            entry_by: data['entry_by'],
            student_name: data['student']['profile']['name'],
            mzu_regn_no: data['student']['mzu_regn_no'],
            subject_name: data['subject']['name'],
            subject_code: data['subject']['code'],
            programme_name: data['subject']['programme']['name'],
            programme_code: data['subject']['programme']['code'],
            specialization_name: data['subject']['specialization']['name']));
      }
      refreshController.loadComplete();
    } catch (ex) {}
  }

  void submitAttendance(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.submitAttendance(studentAttendance);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future deleteAttendance(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.deleteAttendance(id);
      allAttendanceList.clear();
      for (var data in response) {
        allAttendanceList.add(AllAttendanceModel(
            id: data['id'],
            internal_exam_id: data['internal_exam_id'],
            student_id: data['student_id'],
            semester: data['semester'],
            subject_id: data['subject_id'],
            attendance: data['attendance'],
            total: data['total'],
            month_year: data['month_year'],
            status: data['status'],
            entry_by: data['entry_by'],
            student_name: data['student']['profile']['name'],
            mzu_regn_no: data['student']['mzu_regn_no'],
            subject_name: data['subject']['name'],
            subject_code: data['subject']['code'],
            programme_name: data['subject']['programme']['name'],
            programme_code: data['subject']['programme']['code'],
            specialization_name: data['subject']['specialization']['name']));
      }
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future updateAttendance(int id, int attendance, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.updateAttedance(
          id, attendance, month.value.toString(), year.value);
      allAttendanceList.clear();
      for (var data in response) {
        allAttendanceList.add(AllAttendanceModel(
            id: data['id'],
            internal_exam_id: data['internal_exam_id'],
            student_id: data['student_id'],
            semester: data['semester'],
            subject_id: data['subject_id'],
            attendance: data['attendance'],
            total: data['total'],
            month_year: data['month_year'],
            status: data['status'],
            entry_by: data['entry_by'],
            student_name: data['student']['profile']['name'],
            mzu_regn_no: data['student']['mzu_regn_no'],
            subject_name: data['subject']['name'],
            subject_code: data['subject']['code'],
            programme_name: data['subject']['programme']['name'],
            programme_code: data['subject']['programme']['code'],
            specialization_name: data['subject']['specialization']['name']));
      }
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  Future getAllBatch() async {
    var data = await services.getAllBatch();
    return data;
  }

  Future filterAttendances(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    allAttendanceList.clear();
    try {
      var response = await services.filterAttendaces(filterByProgrammeId.value,
          filterByBatchId.value, filterByName.text, filterByRegnNo.text);
      allAttendanceList.clear();
      for (var data in response) {
        allAttendanceList.add(AllAttendanceModel(
            id: data['id'],
            internal_exam_id: data['internal_exam_id'],
            student_id: data['student_id'],
            semester: data['semester'],
            subject_id: data['subject_id'],
            attendance: data['attendance'],
            total: data['total'],
            month_year: data['month_year'],
            status: data['status'],
            entry_by: data['entry_by'],
            student_name: data['student']['profile']['name'],
            mzu_regn_no: data['student']['mzu_regn_no'],
            subject_name: data['subject']['name'],
            subject_code: data['subject']['code'],
            programme_name: data['subject']['programme']['name'],
            programme_code: data['subject']['programme']['code'],
            specialization_name: data['subject']['specialization']['name']));
      }
      onSuccess();
    } catch (ex) {
      mySnackBar(
          'Not Found',
          const Icon(
            Icons.warning,
            color: Colors.red,
          ));
      onError();
    }
  }

  void clearAllFilterForms() {
    filterByName.clear();
    filterByBatchId.value = 0;
    filterByProgrammeId.value = 0;
    filterByRegnNo.clear();
  }
}
