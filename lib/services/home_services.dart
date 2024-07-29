import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class HomeServices extends BaseService {
  Future getUser() async {
    try {
      var response = await client.get(Routes.GET_ME);
      return response.data['data'];
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }

  Future logout() async {
    try {
      var response = await client.delete(Routes.LOGOUT);
      return response;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
