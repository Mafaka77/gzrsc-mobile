import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/models/user_model.dart';
import 'package:lms/screens/add_internal_exam_screen.dart';
import 'package:lms/screens/assign_student_mentor_screen.dart';
import 'package:lms/screens/attendance_screen.dart';
import 'package:lms/screens/dashboard_screen.dart';
import 'package:lms/screens/internal_mark_screen.dart';
import 'package:lms/screens/post_category_screen.dart';
import 'package:lms/screens/post_screen.dart';
import 'package:lms/screens/repositories_screen.dart';
import 'package:lms/screens/repository_category_screen.dart';
import 'package:lms/screens/semester_exam_fees_screen.dart';
import 'package:lms/screens/semester_exam_score_screen.dart';
import 'package:lms/services/home_services.dart';

class HomeController extends GetxController {
  HomeServices services = Get.find(tag: 'homeServices');
  var selectedIndex = 0.obs;
  List<Widget> widgetOptions = <Widget>[
    DashboardScreen(),
    AddInternalExamScreen(),
    const AttendanceScreen(),
    const InternalMarkScreen(),
    SemesterExamFeeScreen(),
    SemesterExamScoreScreen(),
    AssignStudentMentorScreen(),
    RepositoryCategoryScreen(),
    RepositoriesScreen(),
    // PostCategoryScreen(),
    // PostScreen()
  ];
  var userData = <UserModel>{}.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getUser();

    super.onInit();
  }

  Future getUser() async {
    isLoading.value = true;
    try {
      var response = await services.getUser();
      userData.add(UserModel(
        name: response['name'],
      ));
      isLoading.value = false;
      print(userData);
    } catch (ex) {
      isLoading.value = false;
    }
  }

  Future logout(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var response = await services.logout();
      if (response.statusCode == 200) {
        if (response.data['status'] == 400) {
          onSuccess();
        }
      } else {
        onError();
      }
    } catch (ex) {
      onError();
    }
  }
}
