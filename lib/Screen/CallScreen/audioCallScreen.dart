import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/ProfileScreen/controller/profileController.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../utils/string_res.dart';
import '../Chat/controller/chatController.dart';
import '../Chat/model/userModel.dart';

class AudioCallScreen extends StatelessWidget {
  final UserModel target;
  const AudioCallScreen({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    var callId = chatController.getRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudConfig.appId,
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.name ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
//
// // 123
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//
// import '../../utils/string_res.dart';
// import '../Chat/controller/chatController.dart';
// import '../Chat/model/userModel.dart';
// import '../ProfileScreen/controller/profileController.dart';
//
// class AudioCallScreen extends StatefulWidget {
//   final UserModel target;
//   const AudioCallScreen({super.key, required this.target});
//
//   @override
//   State<AudioCallScreen> createState() => _AudioCallScreenState();
// }
//
// class _AudioCallScreenState extends State<AudioCallScreen> {
//   bool _hasPermission = false;
//
//   @override
//   void initState() {
//     super.initState();
//     checkPermissions();
//   }
//
//   Future<void> checkPermissions() async {
//     var mic = await Permission.microphone.request();
//     var cam = await Permission.camera.request();
//
//     if (mic.isGranted && cam.isGranted) {
//       setState(() {
//         _hasPermission = true;
//       });
//     } else {
//       Get.snackbar(
//           "Permission Denied", "Please allow mic & camera permissions");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_hasPermission) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     ProfileController profileController = Get.put(ProfileController());
//     ChatController chatController = Get.put(ChatController());
//     var callId = chatController.getRoomId(widget.target.id!);
//
//     return ZegoUIKitPrebuiltCall(
//       appID: ZegoCloudConfig.appId,
//       appSign: ZegoCloudConfig.appSign,
//       userID: profileController.currentUser.value.id ?? "root",
//       userName: profileController.currentUser.value.name ?? "root",
//       callID: callId,
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
//     );
//   }
// }
