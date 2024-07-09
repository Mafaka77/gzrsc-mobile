import 'package:dio/dio.dart';
import 'package:lms/models/batch_model.dart';
import 'package:lms/models/faculty_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/student_mentor_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class AssignStudentMentorServices extends BaseService {
  Future getAllFaculty() async {
    try {
      var response = await client.get(Routes.GET_ALL_FACULTY);
      var data = response.data['data'];
      return FacultyModel.fromJsonList(data);
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

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

  Future getMentorAllStudents(int specializationId, int batchId) async {
    try {
      var response = await client.get(
        Routes.GET_MENTOR_ALL_STUDENTS,
        data: {
          'specialization_id': specializationId,
          'batch_id': batchId,
        },
      );
      return response.data['data'];
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

  Future submitStudentMentor(List<StudentMentorModel> data) async {
    try {
      var response = await client.post(Routes.SUBMIT_STUDENT_MENTOR, data: {
        'data': data,
      });
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future getStudentsMentor(int id) async {
    try {
      var response = await client.get(Routes.GET_STUDENTS_MENTOR, data: {
        'data': id,
      });
      return response;
    } catch (ex) {}
  }

  Future updateInfo(int id, String info) async {
    try {
      var response = await client.get(Routes.UPDATE_INFO, data: {
        'id': id,
        'info': info,
      });
      print(response);
    } catch (ex) {}
  }
}
