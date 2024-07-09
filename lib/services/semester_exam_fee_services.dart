import 'package:lms/models/semester_exam_fee_model.dart';
import 'package:lms/models/specialization_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class SemesterExamFeeServices extends BaseService {
  Future<List<SemesterExamFeeModel>> getAllSemesterFee(
      int offset, int limit) async {
    try {
      var response = await client.get(Routes.GET_SEMESTER_EXAM_FEE, data: {
        'offset': offset,
        'limit': limit,
      });
      var data = response.data['data'];
      return SemesterExamFeeModel.fromJsonList(data);
    } catch (ex) {
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

  Future filterSemesterExamFee(
      int programmeId, int specializationId, int semester) async {
    try {
      var response = await client.get(Routes.FILTER_SEMESTER_EXAM_FEE, data: {
        'programme_id': programmeId,
        'specialization_id': specializationId,
        'semester': semester,
      });
      return response.data['data'];
    } catch (ex) {
      print(ex);
    }
  }

  Future saveSemesterExamFee(List data) async {
    try {
      var reponse = await client.post(Routes.SAVE_SEMESTER_EXAM_FEE, data: {
        'data': data,
      });
    } catch (ex) {}
  }

  Future<List<SemesterExamFeeModel>> deleteSemesterExamFee(int id) async {
    try {
      var response =
          await client.delete(Routes.DELETE_SEMESTER_EXAM_FEE, data: {
        'id': id,
      });
      var data = response.data['data'];
      return SemesterExamFeeModel.fromJsonList(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<List<SemesterExamFeeModel>> updateAmount(int id, String amount) async {
    try {
      var response = await client.put(Routes.UPDATE_SEMESTER_AMOUNT, data: {
        'id': id,
        'amount': amount,
      });
      var data = response.data['data'];
      return SemesterExamFeeModel.fromJsonList(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
