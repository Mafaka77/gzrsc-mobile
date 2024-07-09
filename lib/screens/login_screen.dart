import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/controllers/login_controller.dart';
import 'package:lms/reusable_widget.dart';
import 'package:lms/snackbar_widget.dart';
import 'package:lms/widgets/sizedbox_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.elliptical(400, 140)),
                          color: Color(0xffE7E7FF),
                        ),
                        height: Get.height * 0.3,
                      ),
                      const Positioned(
                        bottom: 15,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 24,
                                  letterSpacing: 8,
                                  fontWeight: FontWeight.bold),
                            ),
                            // reusableWidget.twoLine(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  sizedBox(40),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.phoneNumber,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Mobile';
                              } else if (value.length < 10) {
                                return 'Enter valid mobile Number';
                              }
                              return null;
                            },
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Mobile',
                              counterText: '',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          sizedBox(20),
                          TextFormField(
                            controller: controller.password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                            obscureText: controller.hidePassword.value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              isDense: true,
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.hidePassword.value =
                                      !controller.hidePassword.value;
                                  controller.update();
                                },
                                icon: controller.hidePassword.isTrue
                                    ? const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      )
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          sizedBox(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                height: Get.height * 0.06,
                                elevation: 0,
                                color: const Color(0xff191c51),
                                minWidth: Get.width * 0.5,
                                onPressed: () {
                                  login(controller, context);
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void login(LoginController controller, BuildContext context) {
    if (controller.formKey.currentState!.validate()) {
      controller.login(() {
        reusableWidget.showLoader(context);
      }, () {
        reusableWidget.hideLoader();
        Get.offAllNamed('/home-screen');
      }, (String message) {
        reusableWidget.hideLoader();
        mySnackBar(
            message,
            const Icon(
              Icons.warning,
              color: Colors.red,
            ));
      });
    } else {
      reusableWidget.hideLoader();
      print('error');
    }
  }
}
