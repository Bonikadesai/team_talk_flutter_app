// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../utils/string_res.dart';
// import '../Chat/controller/chatController.dart';
// import '../Chat/model/userModel.dart';
// import '../ProfileScreen/controller/profileController.dart';
//
// class AudioCallScreen extends StatelessWidget {
//   final UserModel target;
//   const AudioCallScreen({super.key, required this.target});
//
//   @override
//   Widget build(BuildContext context) {
//     ProfileController profileController = Get.put(ProfileController());
//     ChatController chatController = Get.put(ChatController());
//     var callId = chatController.getRoomId(target.id!);
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
//
// // 123
