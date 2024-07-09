import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class LoginServices extends BaseService {
  Future login(String mobile, String password) async {
    try {
      var response = await client.post(Routes.LOGIN, data: {
        'mobile': mobile,
        'password': password,
      });
      return response;
    } catch (ex) {
      Future.error(ex);
    }
  }
}
