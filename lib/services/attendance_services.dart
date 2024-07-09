import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/attendance_model.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/program_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';
import 'package:lms/snackbar_widget.dart';

class AttendanceServices extends BaseService {
  var headers = {
    'Content-Type': 'application/json',
  };
  Future<List<SpecializationModel>> getAllProgram() async {
    try {
      var response = await client.get(Routes.GET_PROGRAM);
      return SpecializationModel.fromJsonList(response.data['program']);
    } catch (ex) {
      print(ex);
      // mySnackBar('Something went Wrong! Try Again', const Icon(Icons.warning));
      return [];
    }
  }

  Future<List<BatchModel>> getBatch(int id) async {
    try {
      var response = await client.get(Routes.GET_BATCH(id));

      return BatchModel.fromJsonList(response.data['batch']);
    } catch (ex) {
      print(ex);
      // mySnackBar('Something went Wrong! Try Again', const Icon(Icons.warning));
      return [];
    }
  }

  Future<List<SubjectModel>> getSubject(int id, int semesterId) async {
    try {
      var response = await client.get(Routes.GET_SUBJECT(id, semesterId));
      return SubjectModel.fromJsonList(response.data['subject']);
    } catch (ex) {
      print(ex);
      // mySnackBar('Something went Wrong! Try Again', const Icon(Icons.warning));
      return [];
    }
  }

  Future<List<InternalExamModel>> getInternalExam() async {
    try {
      var response = await client.get(Routes.GET_INTERNAL_EXAM);

      return InternalExamModel.fromJsonList(response.data['internal']);
    } catch (ex) {
      print(ex);
      // mySnackBar('Something went Wrong! Try Again', const Icon(Icons.warning));
      return [];
    }
  }

  Future filterAttendance(int subjectId, int batchId, int internalExamId,
      int specializationId, int month, String year, String semester) async {
    try {
      var response = await client.get(Routes.FILTER_ATTENDANCE, data: {
        'subject_id': subjectId,
        'batch_id': batchId,
        'internal_exam_id': internalExamId,
        'specialization_id': specializationId,
        'semester': semester,
        'month': month,
        'year': year,
      });

      return response.data['students'];
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

  Future getAllAttendance(int offset, int limit) async {
    try {
      var response = await client.get(Routes.GET_ATTENDANCE, data: {
        'offset': offset,
        'limit': limit,
      });
      return response.data['attendance'];
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future submitAttendance(List<AttendanceModel> studentAttendance) async {
    try {
      var response = await client.post(
        Routes.SUBMIT_ATTENDANCE,
        data: {
          'data': studentAttendance,
        },
      );
      return response.data;
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

  Future deleteAttendance(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_ATTENDANCE, data: {
        'id': id,
      });
      return response.data['attendance'];
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future updateAttedance(
      int id, int attendance, String month, String year) async {
    try {
      var response = await client.put(Routes.UPDATE_ATTENDANCE, data: {
        'id': id,
        'attendance': attendance,
        'month': month,
        'year': year,
      });
      return response.data['attendance'];
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<List<BatchModel>> getAllBatch() async {
    try {
      var response = await client.get(Routes.GET_ALL_BATCH);

      return BatchModel.fromJsonList(response.data['batch']);
    } catch (ex) {
      print(ex);
      // mySnackBar('Something went Wrong! Try Again', const Icon(Icons.warning));
      return [];
    }
  }

  Future filterAttendaces(
      int programmeId, int batchId, String name, String regnNo) async {
    try {
      var response = await client.get(Routes.GET_ATTENDANCE, data: {
        'programme_id': programmeId,
        'batch_id': batchId,
        'name': name,
        'regn_no': regnNo,
      });
      print('${response.statusCode}asdasd');
      return response.data['attendance'];
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
