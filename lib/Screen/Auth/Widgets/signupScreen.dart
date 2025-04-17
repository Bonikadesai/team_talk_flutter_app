import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_btn.dart';
import '../../../common/text_field.dart';
import '../../../common/text_style.dart';
import '../../../utils/assets_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/string_res.dart';
import '../controller/SignupController.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sign up for account",
              style: josefinSansBold(
                fontSize: 30,
                color: colorRes.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Get chatting with friends and family today by signing up for our chat app!",
              textAlign: TextAlign.center,
              style: rubikRegular(
                fontSize: 16,
                color: colorRes.blue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<SignupController>(
              id: 'signup',
              builder: (controller) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: signupController.signupForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CommonTextField(
                            textInputAction: TextInputAction.next,
                            hintText: 'Enter your Username',
                            controller: signupController.userNameController,
                            onChange: signupController.setUserName,
                            prefixIcon: const Icon(
                              Icons.person_2_outlined,
                              color: colorRes.grey,
                            ),
                          ),
                          signupController.userName.isNotEmpty
                              ? Text(signupController.userName,
                                  style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          CommonTextField(
                            textInputAction: TextInputAction.next,
                            hintText: 'Enter your Email',
                            controller: signupController.emailController,
                            onChange: signupController.setEmail,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: colorRes.grey,
                            ),
                          ),
                          signupController.email.isNotEmpty
                              ? Text(signupController.email, style: errorStyle)
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
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
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       height: Get.height * 0.07,
                          //       width: Get.width * 0.45,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         border: Border.all(
                          //           width: 2,
                          //           color: colorRes.blue,
                          //         ),
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           SizedBox(
                          //             height: 25,
                          //             child: Image.asset(assetsRes.google),
                          //           ),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           Text(
                          //             stringRes.google,
                          //             style: rubikRegular(
                          //                 color: colorRes.blue, fontSize: 18),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       height: Get.height * 0.07,
                          //       width: Get.width * 0.45,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         border: Border.all(
                          //           width: 2,
                          //           color: colorRes.blue,
                          //         ),
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           SizedBox(
                          //             height: 25,
                          //             child: Image.asset(assetsRes.google),
                          //           ),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           Text(
                          //             stringRes.google,
                          //             style: rubikRegular(
                          //                 color: colorRes.blue, fontSize: 18),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 40,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonBtn(
                                label: stringRes.signup,
                                onTap: () async {

                                  signupController.onTapSignup();
                                  // User? user =
                                  //   await AuthHelper.authHelper.SignUp(
                                  // email:
                                  //     signupController.emailController.text,
                                  // password: signupController
                                  //     .passwordController.text,
                                  //  await AuthHelper.authHelper.createUser(email, password, name)
                                  //   .then(
                                  // (value) async {
                                  //   Map<String, dynamic> res =
                                  //       await Auth_Helper.auth_helper.SignIn(
                                  //           email: signupController
                                  //               .emailController.text,
                                  //           password: signupController
                                  //               .passwordController.text);
                                  //   if (res['user'] != null) {
                                  //     Get.to(HomeScreen());
                                  //     Get.snackbar(
                                  //       'Chatterly',
                                  //       'Login Successfully ',
                                  //       backgroundColor: colorRes.blue,
                                  //       colorText: Colors.white,
                                  //     );
                                  //     // emailController.clear();
                                  //     // passwordController.clear();
                                  //   } else if (res['error'] != null) {
                                  //     Get.snackbar(
                                  //         'Chatterly', 'Login Failed..',
                                  //         backgroundColor: Colors.red,
                                  //         colorText: Colors.white);
                                  //   }
                                  // },

                                  // if (user != null) {
                                  //   String? profileURL = await FireStore_Helper
                                  //       .fireStore_Helper
                                  //       .uploadUserProfile(
                                  //     uid: user.uid,
                                  //     file:
                                  //         signupController.selectedImage.value!,
                                  //   );
                                  //
                                  //   if (profileURL != null) {
                                  //     await FireStore_Helper.fireStore_Helper
                                  //         .createUserProfile(
                                  //       userProfile: UserProfile(
                                  //         uid: user.uid,
                                  //         name: signupController
                                  //             .userNameController.text,
                                  //         profileUrl: profileURL,
                                  //       ).toMap(), // Convert UserProfile to Map<String, dynamic>
                                  //     );
                                  //     log("=========================");
                                  //     log("=========================");
                                  //     log("=========================");
                                  //     log(user.uid);
                                  //     log(profileURL);
                                  //     log("=========================");
                                  //     log("=========================");
                                  //     log("=========================");
                                  //     // await FireStore_Helper.fireStore_Helper.addUser(data: {});
                                  //   }
                                  // }
//"--------------------------------------------------------------------------------"
                                  // if (user != null) {
                                  //   String? profileURL = await FireStore_Helper
                                  //       .fireStore_Helper
                                  //       .uploadUserProfile(
                                  //     uid: user.uid,
                                  //     // await FireStore_Helper.fireStore_Helper
                                  //     //     .uploadUserProfile(
                                  //     //   uid: user.uid,
                                  //     file:
                                  //         signupController.selectedImage.value!,
                                  //   );
                                  //   if (profileURL != null) {
                                  //     await FireStore_Helper.fireStore_Helper
                                  //         .createUserProfile(
                                  //             userProfile: UserProfile(
                                  //       uid: user.uid,
                                  //       name: signupController
                                  //           .userNameController.text,
                                  //       profileUrl: profileURL,
                                  //     ));
                                  //   }
                                  // }

                                  log("=========================");
                                  //  log(user!.uid);
                                  // log(signupController
                                  //     .selectedImage.value!.path);
                                  // log(Auth_Helper.auth_helper.firebaseAuth
                                  //     .currentUser!.uid);
                                  log(signupController.userNameController.text);
                                  log(signupController.emailController.text);
                                  log(signupController.passwordController.text);
                                  // log(signupController
                                  //     .passwordController.confirmPasswordController.text);
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
                            height: 15,
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
                          //   height: Get.height * 0.03,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       stringRes.alreadyHaveAccount,
                          //       style: rubikRegular(
                          //           fontSize: 14, color: colorRes.grey),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Get.to(LoginScreen());
                          //       },
                          //       child: Text(
                          //         stringRes.login,
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
  }
}
