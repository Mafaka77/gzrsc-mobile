import 'package:lms/services/base_services.dart';
import 'package:lms/services/routes.dart';

class DashboardServices extends BaseService {
  Future getHomeData() async {
    try {
      var response = await client.get(Routes.INDEX);
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
