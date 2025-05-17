import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/Auth/Widgets/loginScreen.dart';

import '../../../common/common_btn.dart';
import '../../../common/text_field.dart';
import '../../../common/text_style.dart';
import '../../../utils/color_res.dart';
import '../../../utils/string_res.dart';
import '../controller/SignupController.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());

    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Create an account",
                style: josefinSansBold(
                    fontSize: 24,
                    color: colorRes.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Sign up now and start exploring",
                textAlign: TextAlign.center,
                style: rubikRegular(
                  fontSize: 16,
                  color: colorRes.lightGrey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<SignupController>(
                id: 'signup',
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Form(
                      key: signupController.signupForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style:
                                TextStyle(fontSize: 18, color: colorRes.black),
                          ),
                          SizedBox(height: 10),
                          CommonTextField(
                            textInputAction: TextInputAction.next,
                            hintText: 'Enter your Username',
                            controller: signupController.userNameController,
                            onChange: signupController.setUserName,
                          ),
                          signupController.userName.isNotEmpty
                              ? Text(signupController.userName,
                                  style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Enter your Email ID",
                            style:
                                TextStyle(fontSize: 18, color: colorRes.black),
                          ),
                          SizedBox(height: 10),
                          CommonTextField(
                            textInputAction: TextInputAction.next,
                            hintText: 'Enter your Email',
                            controller: signupController.emailController,
                            onChange: signupController.setEmail,
                          ),
                          signupController.email.isNotEmpty
                              ? Text(signupController.email, style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Enter your password",
                            style:
                                TextStyle(fontSize: 18, color: colorRes.black),
                          ),
                          SizedBox(height: 10),
                          PasswordField(
                            hintText: 'Enter your Password',
                            controller: signupController.passwordController,
                            onChange: signupController.setPassword,
                            isprefix: true,
                            issufix: true,
                          ),
                          signupController.password.isNotEmpty
                              ? Text(signupController.password,
                                  style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Enter your confirm password",
                            style:
                                TextStyle(fontSize: 18, color: colorRes.black),
                          ),
                          SizedBox(height: 10),
                          PasswordField(
                            hintText: 'Enter your conform password',
                            controller:
                                signupController.confirmPasswordController,
                            onChange: signupController.setConformPassword,
                            isprefix: true,
                            issufix: true,
                          ),
                          signupController.confirmPassword.isNotEmpty
                              ? Text(signupController.confirmPassword,
                                  style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonBtn(
                                label: stringRes.signup,
                                onTap: () async {
                                  signupController.onTapSignup();
                                  log(signupController.userNameController.text);
                                  log(signupController.emailController.text);
                                  log(signupController.passwordController.text);
                                  log("=========================");
                                  signupController.emailController.clear();
                                  signupController.passwordController.clear();
                                  signupController.confirmPasswordController
                                      .clear();
                                }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: rubikRegular(
                                    color: colorRes.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(LoginScreen());
                                },
                                child: Text(
                                  "Login",
                                  style: rubikRegular(
                                      color: colorRes.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
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
