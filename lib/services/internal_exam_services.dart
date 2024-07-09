import 'package:lms/models/internal_exam_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class InternalExamServices extends BaseService {
  Future<List<InternalExamModel>> getAllInternals() async {
    try {
      var response = await client.get(Routes.GET_INTERNAL_EXAM);
      return InternalExamModel.fromJsonList(response.data['internals']);
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

  Future<List<InternalExamModel>> addInternalExam(
      int id, String name, String code, String status) async {
    try {
      var response = await client.post(Routes.ADD_INTERNAL_EXAM, data: {
        'id': id,
        'name': name,
        'code': code,
        'status': status,
      });
      return InternalExamModel.fromJsonList(response.data['internal']);
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

  Future<List<InternalExamModel>> deleteInternalExam(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_INTERNAL_EXAM, data: {
        'id': id,
      });
      return InternalExamModel.fromJsonList(response.data['internals']);
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }
}
