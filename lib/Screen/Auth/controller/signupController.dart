import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/string_res.dart';
import '../Helper/auth_helper.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupForm = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String userName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  var galleryImage;

  void setUserName(String value) {
    userName = value.trim();
  }

  validateUserName() {
    if (userNameController.text.trim() == "") {
      userName = stringRes.usernameerrorMessage;
    } else {
      userName = "";
    }
    update(['signup']);
  }

  void setEmail(String value) {
    email = value.trim();
  }

  validateEmail() {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (emailController.text.trim() == "") {
      email = stringRes.emailErrorRegister;
    } else if (!emailRegex.hasMatch(email)) {
      email = stringRes.emailErrorRegister1;
    } else {
      email = "";
    }
    update(['signup']);
  }

  void setPassword(String value) {
    password = value.trim();
  }

  validatePassword() {
    if (passwordController.text.trim() == "") {
      password = stringRes.passwordErrorMessage;
    } else if (password.length < 8) {
      password = stringRes.passwordErrorMessage1;
    } else {
      password = "";
    }
    update(['signup']);
  }

  void setConformPassword(String value) {
    confirmPassword = value.trim();
  }

  conformPasswordValidation() {
    if (confirmPasswordController.text.trim() == "") {
      confirmPassword = stringRes.ConformPassworderror;
    } else if (confirmPasswordController.text.length < 8) {
      confirmPassword = stringRes.confirmPasswordError2;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPassword = stringRes.match.tr;
    } else {
      confirmPassword = '';
    }
    update(['signup']);
  }

  bool validationSignup() {
    validateUserName();
    validateEmail();
    validatePassword();
    conformPasswordValidation();

    if (userName == '' &&
        email == '' &&
        password == '' &&
        confirmPassword == '') {
      return true;
    } else {
      return false;
    }
  }

  onTapSignup() {
    if ((validationSignup())) {
      // emailController.clear();
      // passwordController.clear();
      // confirmPasswordController.clear();
      AuthHelper.authHelper.createUser(
        emailController.text,
        passwordController.text,
        userNameController.text,
      );
      //Get.to(() => HomePage());
      // Get.snackbar(
      //   "SUCCESSFULLY",
      //   "Create Account Successfully with Email..",
      //   backgroundColor: colorRes.blue,
      //   colorText: Colors.white,
      // );
    }
  }
}
