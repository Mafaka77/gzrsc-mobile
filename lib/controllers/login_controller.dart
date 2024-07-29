import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/services/login_services.dart';

class LoginController extends GetxController {
  LoginServices services = Get.find(tag: 'loginServices');
  GetStorage storage = GetStorage();
  final formKey = GlobalKey<FormState>();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var hidePassword = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future login(Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.login(phoneNumber.text, password.text);
      if (response.statusCode == 200) {
        switch (response.data['status']) {
          case 401:
            onError(response.data['message']);
            break;
          case 405:
            onError(response.data['message']);
            break;
          case 200:
            {
              var token = response.data['token'];
              var userId = response.data['user']['id'];
              storage.write('token', token);
              storage.write('user_id', userId);
              onSuccess();
            }
        }
      } else {
        onError(response.data['message']);
      }
    } catch (ex) {
      print(ex);
      onError(ex);
    }
  }
}
