import 'package:lms/models/batch_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class SemesterExamScoreServices extends BaseService {
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

  Future getSemesterExamScore(int batchId, int programmeId,
      int specializationId, String semester) async {
    try {
      var response = await client.get(Routes.GET_SEMESTER_EXAM_SCORE, data: {
        'batch_id': batchId,
        'programme_id': programmeId,
        'specialization_id': specializationId,
        'semester': semester,
      });
      return response.data['student'];
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future getSubjectBasedOnId(int studentId, int semester, int specializationId,
      int programmeId) async {
    try {
      var response = await client.get(Routes.GET_SEMESTER_SUBJECTS, data: {
        'student_id': studentId,
        'semester': semester,
        'specialization_id': specializationId,
        'programme_id': programmeId,
      });
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future saveSemesterGrade(List data) async {
    try {
      var response = await client.post(Routes.SAVE_SEMESTER_GRADE, data: {
        'data': data,
      });
    } catch (ex) {}
  }

  Future getSemesterMarkDetails(int studentId, int semester) async {
    try {
      var response = await client.get(Routes.GET_SEMESTER_MARK_DETAILS, data: {
        'student_id': studentId,
        'semester': semester,
      });
      return response.data['data'];
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
