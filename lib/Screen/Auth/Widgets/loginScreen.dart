import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/Auth/Widgets/signupScreen.dart';

import '../../../common/common_btn.dart';
import '../../../common/text_field.dart';
import '../../../common/text_style.dart';
import '../../../utils/color_res.dart';
import '../../../utils/string_res.dart';
import '../../ForgotPassword/forgotPassword.dart';
import '../controller/loginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void requestPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome ",
                        style: josefinSansBold(
                            fontSize: 24,
                            color: colorRes.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SvgPicture.asset("assets/Icons/fi_17895307.svg")
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "to ",
                        style: josefinSansBold(
                            fontSize: 24,
                            color: colorRes.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "TeamTalk ",
                        style: josefinSansBold(
                            fontSize: 24,
                            color: colorRes.blue,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Login to your account",
                textAlign: TextAlign.center,
                style: rubikRegular(
                  fontSize: 16,
                  color: colorRes.lightGrey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<LoginController>(
                id: 'login',
                builder: (controller) {
                  return Form(
                    key: loginController.loginForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter your Email ID",
                          style: TextStyle(fontSize: 18, color: colorRes.black),
                        ),
                        SizedBox(height: 10),
                        CommonTextField(
                          textInputAction: TextInputAction.next,
                          hintText: 'Enter your Email',
                          controller: loginController.emailController,
                          onChange: loginController.setEmail,
                          // prefixIcon: const Icon(
                          //   Icons.email_outlined,
                          //   color: colorRes.grey,
                          // ),
                        ),
                        loginController.email.isNotEmpty
                            ? Text(loginController.email, style: errorStyle)
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Enter your password",
                          style: TextStyle(fontSize: 18, color: colorRes.black),
                        ),
                        SizedBox(height: 10),
                        PasswordField(
                          hintText: 'Enter your Password',
                          controller: loginController.passwordController,
                          onChange: loginController.setPassword,
                          isprefix: true,
                          issufix: true,
                        ),
                        loginController.password.isNotEmpty
                            ? Text(loginController.password, style: errorStyle)
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const ForgotPassword());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              stringRes.forgotPassword,
                              style: rubikRegular(
                                  fontSize: 14, color: colorRes.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(
                          () => loginController.isLoading.value
                              ? CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CommonBtn(
                                      label: stringRes.login,
                                      onTap: () async {
                                        //   if (loginController.onTapLogin()) {
                                        loginController.onTapLogin();

                                        //    }

                                        log("=================");
                                        log(loginController
                                            .emailController.text);
                                        log(loginController
                                            .passwordController.text);
                                        log(loginController.password);
                                        log("=================");
                                      }),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account? ",
                              style: rubikRegular(
                                  color: colorRes.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(SignupScreen());
                              },
                              child: Text(
                                "Sign Up",
                                style: rubikRegular(
                                    color: colorRes.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
