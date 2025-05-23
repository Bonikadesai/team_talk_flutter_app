import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_talk_flutter_app/Screen/Chat/push_notificaion/notification_service.dart';

import '../../Chat/model/userModel.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  GoogleSignIn googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  // For Login

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed("/homePage");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> createUser(String email, String password, String name) async {
    isLoading.value = true;

    print("===================>>> ${email}");
    print("===================>>> ${password}");
    print("===================>>> ${name}");

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await initUser(email, name);
      print("Account Created 🔥🔥");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    // catch (e) {
    //   print("--------------->>>> $e");
    // }
    isLoading.value = false;
  }

  Future<void> logoutUser() async {
    await auth.signOut();
    Get.offAllNamed("/authPage");
  }

  String? fcmToken;

  ChatNotificationServices services = ChatNotificationServices();

  Future<void> initUser(String email, String name) async {
    fcmToken = await services.getDeviceToken();
    var newUser = UserModel(
        email: email,
        name: name,
        id: auth.currentUser!.uid,
        fcmToken: fcmToken);
    print("=================================== ${newUser.toJson()}");

    try {
      await db.collection("users").doc(auth.currentUser!.uid).set(
            newUser.toJson(),
          );
      Get.offAllNamed("/homePage");
    } catch (ex) {
      print("=================================== ${ex}");
    }
  }

  // Future<User?> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //
  //   var credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   UserCredential userCredential = await auth.signInWithCredential(credential);
  //
  //   User? user = userCredential.user;
  //   return user;
  // }

  // Future<void> deleteUser({required String uid}) async {
  //   await db.collection("users").doc(auth.currentUser!.uid).delete();
  // }
}
