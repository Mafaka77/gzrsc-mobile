import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lms/models/repositories_model.dart';
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

  Future getMyProfile() async {
    try {
      var response = await client.get(Routes.GET_ME);
      return response.data['data'];
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

  Future updateRepositoryCategories(int id, String name, String status) async {
    try {
      var response =
          await client.put(Routes.UPDATE_REPOSITORY_CATEGORIES, data: {
        'id': id,
        'name': name,
        'status': status,
      });
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<List<RepositoriesModel>> getAllRepositories() async {
    try {
      var response = await client.get(Routes.GET_ALL_REPOSITORIES);
      return RepositoriesModel.fromJsonList(response.data['data']);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<List<RepositoryCategoryModel>> getAllCategories() async {
    try {
      var response = await client.get(Routes.GET_ALL_CATEGORIES);
      return RepositoryCategoryModel.fromJsonList(response.data['data']);
    } catch (ex) {
      return [];
    }
  }

  Future saveRepositories(int catId, String title, String description,
      File? file, String date, String fileName, int submittedBy) async {
    try {
      FormData formData = FormData.fromMap({
        'category_id': catId,
        'title': title,
        'description': description,
        'file': file!.path == ''
            ? null
            : await MultipartFile.fromFile(file.path, filename: fileName),
        'date': date,
        'submitted_by': submittedBy,
      });
      var response =
          await client.post(Routes.SAVE_REPOSITORIES, data: formData);
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future deleteRepositories(int id) async {
    try {
      var response =
          await client.delete(Routes.DELETE_REPOSITORIES, data: {'id': id});
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
