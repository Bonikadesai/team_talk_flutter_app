import 'dart:developer';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/Home/homeScreen.dart';
import 'package:team_talk_flutter_app/utils/color_res.dart';

import '../../../common/notification.dart';
import '../../../utils/assets_res.dart';
import '../../Chat/chatScreen.dart';
import '../../Chat/controller/chatController.dart';
import '../../Chat/model/ChatRoomModel.dart';
import '../../Chat/push_notificaion/notification_service.dart';
import '../../ContactScreen/controller/contactController.dart';
import '../../ProfileScreen/controller/profileController.dart';
import 'ChatTile.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ContactController contactController = Get.put(ContactController());
  ProfileController profileController = Get.put(ProfileController());
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    contactController.getChatRoom(contactController.searchController.text);
    notificationCalling();
    super.initState();
  }

  ChatNotificationServices service = ChatNotificationServices();
  notificationCalling() async {

    // service.firebaseInit(context);
    // service.isRefreshToken();

    service.getDeviceToken().then((value) {
      print("token:$value");
    });
  }

  @override
  void dispose() {
    log("call dispose");
    isShowSearchField.value = false;
    contactController.searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      builder: (controller) => Column(
        children: [
          ValueListenableBuilder(
            valueListenable: isShowSearchField,
            builder: (context, value, child) => Visibility(
              visible: value,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: TextFormField(
                  controller: contactController.searchController,
                  onChanged: (value) {
                    contactController.getChatRoom(value);
                  },
                  cursorColor: colorRes.blue,
                  style: TextStyle(color: colorRes.blue, fontSize: 15),
                  cursorHeight: 17.0,
                  decoration: InputDecoration(
                    hintText: "Please Enter Search Text",
                    hintStyle: TextStyle(color: colorRes.blue, fontSize: 15),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorRes.blue)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorRes.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorRes.blue)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: colorRes.blue)),
                  ),
                ),
              ),
            ),
          ),
          // You can now use the stream in your UI
          Expanded(
            child: StreamBuilder<List<ChatRoomModel>>(
              stream: contactController.chatRoomController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final chatRooms = snapshot.data ?? [];
                return chatRooms.isNotEmpty
                    ? ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          final chatRoom = chatRooms[index];
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              chatController.markMessagesAsRead(chatRoom.id!);
                              Get.to(
                                ChatPage(
                                  userModel: (chatRoom.receiver!.id ==
                                          profileController.currentUser.value.id
                                      ? chatRoom.sender
                                      : chatRoom.receiver)!,
                                ),
                              );
                            },
                            child: GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Are You Sure?"),
                                      content: const Text(
                                          "Do you want to delete user?"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            // await AuthHelper.authHelper
                                            //     .deleteUser(uid: e[index].id!);
                                            // await FireStore_Helper.fireStore_Helper
                                            //     .deleteUser(uid: data[i]['uid']);
                                            Get.back(); // Close the dialog after deletion
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back(); // Close the dialog
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ChatTile(
                                imageUrl: (chatRoom.receiver!.id ==
                                            profileController
                                                .currentUser.value.id
                                        ? chatRoom.sender!.profileImage
                                        : chatRoom.receiver!.profileImage) ??
                                    assetsRes.defaultProfileUrl,
                                name: (chatRoom.receiver!.id ==
                                        profileController.currentUser.value.id
                                    ? chatRoom.sender!.name
                                    : chatRoom.receiver!.name)!,
                                lastChat:
                                    chatRoom.lastMessage ?? "Last Message",
                                lastTime: chatRoom.lastMessageTimestamp ??
                                    "Last Time",
                              ),
                            ),
                          );
                          // Build your UI with the chatRoom
                        },
                      )
                    : Center(child: Text("No Data Found"));
              },

              // StreamBuilder<List<ChatRoomModel>>(
              //   stream: contactController
              //       .getChatRoom(contactController.searchController.text),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //     if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     }
              //
              //     List<ChatRoomModel>? e = snapshot.data;
              //
              //     // List<ChatRoomModel>? e = snapshot.data
              //     //     ?.where((e) =>
              //     //         e.sender?.name
              //     //             ?.toString()
              //     //             .toLowerCase()
              //     //             .contains(searchController.text.toLowerCase()) ??
              //     //         false)
              //     //     .toList();
              //     // var filteredMenuCategoryList = menuManagementController
              //     //     .menuManagementCategoryList
              //     //     .where((element) {
              //     //   return element["name"].toString().toLowerCase().contains(
              //     //       menuManagementController.categoriesSearchController.text
              //     //           .toLowerCase());
              //     // }).toList();
              //
              //     return
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
