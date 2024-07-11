import 'package:lms/models/batch_model.dart';
import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/models/subject_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class InternalMarkServices extends BaseService {
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

      return InternalExamModel.fromJsonList(response.data['internals']);
    } catch (ex) {
      print(ex);
      // mySnackBar('Something went Wrong! Try Again', const Icon(Icons.warning));
      return [];
    }
  }

  Future filterInternalMarks(int internalExamId, int batchId, int subjectId,
      int semester, int specializationId) async {
    try {
      var response = await client.get(Routes.FILTER_INTERNAL_MARKS, data: {
        'internal_exam_id': internalExamId,
        'batch_id': batchId,
        'subject_id': subjectId,
        'semester': semester,
        'specialization_id': specializationId,
      });
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future submitInternalExamMarks(List internalExamMarks) async {
    try {
      var response =
          await client.post(Routes.SUBMIT_INTERNAL_EXAM_MARKS, data: {
        'data': internalExamMarks,
      });
      print(response.data);
    } catch (ex) {
      print(ex);
    }
  }

  Future getAllStudents(int offset, int limit, int programId, int batchId,
      String name, String regNo) async {
    try {
      var response = await client.get(
        Routes.GET_INTERNAL_ALL_STUDENTS,
        data: {
          'offset': offset,
          'limit': limit,
          'program_id': programId,
          'batch_id': batchId,
          'student_name': name,
          'student_reg_no': regNo,
        },
      );
      return response.data;
    } catch (ex) {}
  }

  // Future getAllProgramme() async {
  //   try {
  //     var response = await client.get(Routes.GET_ALL_PROGRAMME);
  //     return response.data['data'];
  //   } catch (ex) {
  //     Future.error(ex);
  //   }
  // }
  Future getInternalMarksBySId(int studentId) async {
    try {
      var response = await client.get(
        Routes.GET_INTERNAL_MARKS_BY_ID,
        data: {'student_id': studentId},
      );
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<List<BatchModel>> getAllBatchFilter() async {
    try {
      var response = await client.get(Routes.GET_ALL_BATCH_FILTER);
      return BatchModel.fromJsonList(response.data['batch']);
    } catch (ex) {
      return [];
    }
  }
}
