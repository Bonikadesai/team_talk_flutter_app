import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/Auth/Widgets/loginScreen.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  void onInit() {
    super.onInit();
    splashHandle();
  }

  void splashHandle() async {
    await Future.delayed(
      const Duration(seconds: 8),
    );
    if (auth.currentUser == null) {
      Get.to(LoginScreen());
      //Get.offAllNamed("/authPage");
    } else {
      Get.offAllNamed("/homePage");
      print(auth.currentUser!.email);
    }
    print("hello");
  }
}
