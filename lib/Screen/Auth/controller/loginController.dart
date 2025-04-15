import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/string_res.dart';
import '../Helper/auth_helper.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  String email = "";
  String password = "";

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
    update(['login']);
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
    update(['login']);
  }

  bool validationLogin() {
    validateEmail();
    validatePassword();

    if (email == '' && password == '') {
      return true;
    } else {
      return false;
    }
  }

  onTapLogin() async {
    if (validationLogin()) {
      AuthHelper.authHelper
          .login(emailController.text, passwordController.text);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String? token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'fcmToken': token});
    }
    //   Map<String, dynamic> res = await Auth_Helper.auth_helper.SignIn(
    //       email: emailController.text, password: passwordController.text);
    //   if (res['user'] != null) {
    //     Get.to(HomeScreen());
    //     Get.snackbar(
    //       'Chatterly',
    //       'Login Succesfully ',
    //       backgroundColor: colorRes.blue,
    //       colorText: Colors.white,
    //     );
    //     emailController.clear();
    //     passwordController.clear();
    //   } else if (res['error'] != null) {
    //     Get.snackbar('Chatterly', 'Login Failed..',
    //         backgroundColor: Colors.red, colorText: Colors.white);
    //   }
    //   // Get.to(() => HomeScreen());
    // }
  }
}
