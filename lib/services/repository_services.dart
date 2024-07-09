import 'package:lms/models/repository_category_model.dart';
import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class RepositoryServices extends BaseService {
  Future<List<RepositoryCategoryModel>> getAllRepositoryCategories() async {
    try {
      var response = await client.get(Routes.GET_ALL_REPOSITORY_CATEGORIES);
      print(response.data);
      return RepositoryCategoryModel.fromJsonList(response.data['data']);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future deleteRepositoryCategories(int id) async {
    try {
      var response =
          await client.delete(Routes.DELETE_REPOSITORY_CATEGORIES, data: {
        'id': id,
      });
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future saveRepositoryCategories(String name) async {
    try {
      var response = await client
          .post(Routes.SAVE_REPOSITORY_CATEGORIES, data: {'name': name});
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
