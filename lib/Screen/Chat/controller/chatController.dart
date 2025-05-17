import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../CallScreen/model/audioCall.dart';
import '../../ContactScreen/controller/contactController.dart';
import '../../ProfileScreen/controller/profileController.dart';
import '../model/ChatModel.dart';
import '../model/ChatRoomModel.dart';
import '../model/userModel.dart';
import '../push_notificaion/notification_service.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  RxString selectedImagePath = "".obs;
  @override
  ProfileController profileController = Get.put(ProfileController());
  ContactController contactController = Get.put(ContactController());
  ChatNotificationServices services = ChatNotificationServices();

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReciver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  // Future<void> sendMessage(
  //     String targetUserId, String message, UserModel targetUser) async {
  //   isLoading.value = true;
  //   String chatId = uuid.v6();
  //   String roomId = getRoomId(targetUserId);
  //   DateTime timestamp = DateTime.now();
  //   String nowTime = DateFormat('hh:mm a').format(timestamp);
  //
  //   UserModel sender =
  //       getSender(profileController.currentUser.value, targetUser);
  //   UserModel receiver =
  //       getReciver(profileController.currentUser.value, targetUser);
  //
  //   RxString imageUrl = "".obs;
  //   if (selectedImagePath.value.isNotEmpty) {
  //     imageUrl.value =
  //         await profileController.uploadFileToFirebase(selectedImagePath.value);
  //   }
  //   var newChat = ChatModel(
  //     id: chatId,
  //     message: message,
  //     imageUrl: imageUrl.value,
  //     senderId: auth.currentUser!.uid,
  //     receiverId: targetUserId,
  //     senderName: profileController.currentUser.value.name,
  //     timestamp: DateTime.now().toString(),
  //     readStatus: "unread",
  //   );
  //
  //   var roomDetails = ChatRoomModel(
  //     id: roomId,
  //     lastMessage: message,
  //     lastMessageTimestamp: nowTime,
  //     sender: sender,
  //     receiver: receiver,
  //     timestamp: DateTime.now().toString(),
  //     unReadMessNo: 0,
  //   );
  //   try {
  //     await db
  //         .collection("chats")
  //         .doc(roomId)
  //         .collection("messages")
  //         .doc(chatId)
  //         .set(
  //           newChat.toJson(),
  //         );
  //     selectedImagePath.value = "";
  //     await db.collection("chats").doc(roomId).set(
  //           roomDetails.toJson(),
  //         );
  //     await contactController.saveContact(targetUser);
  //   } catch (e) {
  //     print(e);
  //   }
  //   isLoading.value = false;
  // }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser,
      {String imagePath = '', required BuildContext context}) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);

    UserModel sender =
        getSender(profileController.currentUser.value, targetUser);
    UserModel receiver =
        getReciver(profileController.currentUser.value, targetUser);

    String imageUrl = '';
    log('targetUser :${targetUser.name}');

    try {
      // Upload image if selected
      if (imagePath.isNotEmpty) {
        imageUrl = await profileController.uploadFileToFirebase(imagePath);
        log("imageUrl :$imageUrl");
        if (imageUrl.isEmpty) {
          throw Exception("Failed to upload image");
        }
      }

      var newChat = ChatModel(
        id: chatId,
        message: message,
        imageUrl: imageUrl,
        senderId: auth.currentUser!.uid,
        receiverId: targetUserId,
        senderName: profileController.currentUser.value.name,
        timestamp: timestamp.toString(),
        // fcmToken: targetUser.fcmToken ?? "",
        readStatus: "unread",
      );

      log('newChat :${newChat.toJson()}');

      log('message____:$message');
      var roomDetails = ChatRoomModel(
        id: roomId,
        lastMessage: message.isNotEmpty ? message : "Image",
        lastMessageTimestamp: nowTime,
        sender: sender,
        receiver: receiver,
        timestamp: timestamp.toString(),
        unReadMessNo: targetUserId == auth.currentUser!.uid ? 0 : 1,
      );

      log('roomDetails :${roomDetails.toJson()}');
      // Save message to Firestore
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(newChat.toJson());

      // Update chat room
      await db.collection("chats").doc(roomId).set(roomDetails.toJson());

      // Update contacts
      await contactController.saveContact(targetUser);
      try {
        // services.forGroundMessage();
        services.triggerNotification(context,
            message: message,
            user: targetUser,
            chatModel: newChat,
            roomDetails: roomDetails);
      } catch (e) {
        log("message firebaseInit:$e");
      }

      // Clear inputs
      selectedImagePath.value = "";
    } catch (e) {
      print("Error sending message: $e");
      Get.snackbar("Error", "Failed to send message");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Stream<UserModel> getStatus(String uid) {
    return db.collection('users').doc(uid).snapshots().map(
      (event) {
        return UserModel.fromJson(event.data()!);
      },
    );
  }

  Stream<List<CallModel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => CallModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Stream<int> getUnreadMessageCount(
    String roomId,
  ) {
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .where("readStatus", isEqualTo: "unread")
        .where("senderId", isNotEqualTo: profileController.currentUser.value.id)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<void> markMessagesAsRead(String roomId) async {
    QuerySnapshot<Map<String, dynamic>> messagesSnapshot = await db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .where("readStatus", isEqualTo: "unread")
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> messageDoc
        in messagesSnapshot.docs) {
      String senderId = messageDoc.data()["senderId"];
      if (senderId != profileController.currentUser.value.id) {
        await db
            .collection("chats")
            .doc(roomId)
            .collection("messages")
            .doc(messageDoc.id)
            .update({"readStatus": "read"});
      }
    }
  }
}
