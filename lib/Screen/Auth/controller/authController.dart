import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Email sent", "Check your email now");
    } catch (ex) {
      print(ex);
      Get.snackbar("Error", ex.toString());
    }
  }
}
