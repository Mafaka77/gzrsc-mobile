import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class PostServices extends BaseService {
  Future getAllPostCategory() async {
    try {
      var response = await client.get(Routes.GET_ALL_POST_CATEGORY);
    } catch (ex) {}
  }
}
