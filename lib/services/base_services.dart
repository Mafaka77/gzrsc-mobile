import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/screens/login_screen.dart';

class BaseService extends GetConnect implements GetxService {
  late Dio client;
  GetStorage storage = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    client = Dio();
    client.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        var token = await storage.read('token');
        if (token != null && token != '') {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (error, handler) async {
        print(error.response?.statusCode);
        var storage = const FlutterSecureStorage();
        if (error.response?.statusCode == 401) {
          await storage.delete(key: 'token');
          Get.offAll(() => LoginScreen());
        }
        handler.next(error);
      },
    ));
  }
}
