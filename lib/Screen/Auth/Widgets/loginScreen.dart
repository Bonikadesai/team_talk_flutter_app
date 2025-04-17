import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_btn.dart';
import '../../../common/text_field.dart';
import '../../../common/text_style.dart';
import '../../../utils/assets_res.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Login on your account",
              style: josefinSansBold(
                fontSize: 30,
                color: colorRes.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Welcome back! Sign in using your social account or email to continue us",
              textAlign: TextAlign.center,
              style: rubikRegular(
                fontSize: 16,
                color: colorRes.blue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<LoginController>(
              id: 'login',
              builder: (controller) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginController.loginForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextField(
                            textInputAction: TextInputAction.next,
                            hintText: 'Enter your Email',
                            controller: loginController.emailController,
                            onChange: loginController.setEmail,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: colorRes.grey,
                            ),
                          ),
                          loginController.email.isNotEmpty
                              ? Text(loginController.email, style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          PasswordField(
                            hintText: 'Enter your Password',
                            controller: loginController.passwordController,
                            onChange: loginController.setPassword,
                            isprefix: true,
                            issufix: true,
                          ),
                          loginController.password.isNotEmpty
                              ? Text(loginController.password,
                                  style: errorStyle)
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
                          Center(
                            child: Text(
                              "or continue with",
                              style: rubikRegular(
                                color: colorRes.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // User? res = await AuthHelper.authHelper
                                  //     .signInWithGoogle();
                                  // if (res != null) {
                                  //   Get.to(HomePage(), arguments: res);
                                  //   Get.snackbar(
                                  //     "SUCCESSFULLY",
                                  //     "Login Successfully with Google😊..",
                                  //   );
                                  // } else {
                                  //   Get.snackbar("FAILURE", "Login Failed!!",
                                  //       backgroundColor: Colors.red);
                                  // }
                                },
                                child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: Image.asset(assetsRes.google)),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: Image.asset(assetsRes.call)),
                              ),
                            ],
                          ),

                          // SizedBox(
                          //   height: Get.height * 0.12,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       stringRes.dontHaveAccount,
                          //       style: rubikRegular(
                          //           fontSize: 14, color: colorRes.grey),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Get.to(SignupScreen());
                          //       },
                          //       child: Text(
                          //         stringRes.signup,
                          //         style: rubikRegular(
                          //           fontSize: 14,
                          //           color: colorRes.blue,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    // return Column(
    //   children: [
    //     const SizedBox(height: 40),
    //     TextField(
    //       controller: email,
    //       decoration: const InputDecoration(
    //         hintText: "Email",
    //         prefixIcon: Icon(
    //           Icons.alternate_email_rounded,
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 30),
    //     TextField(
    //       controller: password,
    //       decoration: const InputDecoration(
    //         hintText: "Passowrd",
    //         prefixIcon: Icon(
    //           Icons.password_outlined,
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 10),
    //     Row(
    //       children: [
    //         InkWell(
    //           onTap: () {
    //             Get.to(ForgotPassword());
    //           },
    //           child: Text("Forgot Password ? ",
    //               style: TextStyle(
    //                 fontSize: 13,
    //                 color: Theme.of(context).colorScheme.primary,
    //               )),
    //         )
    //       ],
    //     ),
    //     const SizedBox(height: 60),
    //     Obx(
    //       () => authController.isLoading.value
    //           ? CircularProgressIndicator()
    //           : Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 PrimaryButton(
    //                   ontap: () {},
    //                   btnName: "LOGIN",
    //                   icon: Icons.lock_open_outlined,
    //                 ),
    //               ],
    //             ),
    //     )
    //   ],
    // );
  }
}
