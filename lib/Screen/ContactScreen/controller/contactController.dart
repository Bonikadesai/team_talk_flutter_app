import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Chat/model/ChatRoomModel.dart';
import '../../Chat/model/userModel.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  void onInit() async {
    super.onInit();
    await getUserList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();
      await db.collection("users").get().then(
            (value) => {
              userList.value = value.docs
                  .map(
                    (e) => UserModel.fromJson(e.data()),
                  )
                  .toList(),
            },
          );
    } catch (ex) {
      print(ex);
    }
    isLoading.value = false;
  }

  var searchQuery = "".obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    log('searchQuery.value :${searchQuery.value}');
  }

  List<ChatRoomModel> myChatRoomList = [];
  StreamController<List<ChatRoomModel>> chatRoomController =
      StreamController<List<ChatRoomModel>>.broadcast();
  getChatRoom(String searchText) {
    if (searchText.isEmpty) {
      db
          .collection('chats')
          .orderBy("timestamp", descending: true)
          .snapshots()
          .listen((snapshot) {
        myChatRoomList = snapshot.docs
            .map((doc) => ChatRoomModel.fromJson(doc.data()))
            .where((chatRoom) => chatRoom.id!.contains(auth.currentUser!.uid))
            .toList();
        chatRoomController.add(myChatRoomList); // Update stream
      });
    } else {
      db
          .collection('chats')
          .orderBy("timestamp", descending: true)
          .snapshots()
          .listen((snapshot) {
        myChatRoomList = snapshot.docs
            .map((doc) => ChatRoomModel.fromJson(doc.data()))
            .where((chatRoom) => chatRoom.id!.contains(auth.currentUser!.uid))
            .where(
              (element) =>
                  element.sender?.name
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false,
            )
            .toList();
        chatRoomController.add(myChatRoomList); // Update stream
      });
    }
  }

  Future<void> saveContact(UserModel user) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("contacts")
          .doc(user.id)
          .set(user.toJson());
    } catch (ex) {
      if (kDebugMode) {
        print("Error while saving Contact" + ex.toString());
      }
    }
  }

  Stream<List<UserModel>> getContacts() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => UserModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }
}
