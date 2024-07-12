import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/screens/home_screen.dart';
import 'package:lms/screens/login_screen.dart';
import 'package:lms/services/assign_student_mentor_services.dart';
import 'package:lms/services/attendance_services.dart';
import 'package:lms/services/dashboard_services.dart';
import 'package:lms/services/home_services.dart';
import 'package:lms/services/internal_exam_services.dart';
import 'package:lms/services/internal_mark_services.dart';
import 'package:lms/services/login_services.dart';
import 'package:lms/services/post_services.dart';
import 'package:lms/services/repository_services.dart';
import 'package:lms/services/semester_exam_fee_services.dart';
import 'package:lms/services/semester_exam_score_services.dart';

GetStorage storage = GetStorage();
String? token;
void main() async {
  Get.put(LoginServices(), tag: 'loginServices');
  Get.put(AttendanceServices(), tag: 'attendanceServices');
  Get.put(InternalMarkServices(), tag: 'internalMarkServices');
  Get.put(InternalExamServices(), tag: 'internalExamServices');
  Get.put(SemesterExamFeeServices(), tag: 'semesterExamFeeServices');
  Get.put(SemesterExamScoreServices(), tag: 'semesterExamScoreServices');
  Get.put(HomeServices(), tag: 'homeServices');
  Get.put(DashboardServices(), tag: 'dashboardServices');
  Get.put(AssignStudentMentorServices(), tag: 'assignStudentServices');
  Get.put(RepositoryServices(), tag: 'repositoryServices');
  Get.put(PostServices(), tag: 'postServices');
  await GetStorage.init();
  token = storage.read('token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GZRSC',
      theme: _buildTheme(Brightness.light),
      // home: const HomeScreen(),
      initialRoute: token == null ? '/login-screen' : '/home-screen',
      getPages: [
        GetPage(name: '/home-screen', page: () => const HomeScreen()),
        GetPage(name: '/login-screen', page: () => LoginScreen())
      ],
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);
  return baseTheme.copyWith(
    scaffoldBackgroundColor: const Color(0xffEDEDFF),
    textTheme: GoogleFonts.robotoMonoTextTheme(baseTheme.textTheme),
  );
}
