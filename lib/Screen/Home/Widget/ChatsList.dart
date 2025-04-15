import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets_res.dart';
import '../../Chat/chatScreen.dart';
import '../../Chat/controller/chatController.dart';
import '../../Chat/model/ChatRoomModel.dart';
import '../../ContactScreen/controller/contactController.dart';
import '../../ProfileScreen/controller/profileController.dart';
import 'ChatTile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder<List<ChatRoomModel>>(
      stream: contactController.getChatRoom(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<ChatRoomModel>? e = snapshot.data;

        return ListView.builder(
          itemCount: e!.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                chatController.markMessagesAsRead(e[index].id!);
                Get.to(
                  ChatPage(
                    userModel: (e[index].receiver!.id ==
                            profileController.currentUser.value.id
                        ? e[index].sender
                        : e[index].receiver)!,
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
                        content: const Text("Do you want to delete user?"),
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
                  imageUrl: (e[index].receiver!.id ==
                              profileController.currentUser.value.id
                          ? e[index].sender!.profileImage
                          : e[index].receiver!.profileImage) ??
                      assetsRes.defaultProfileUrl,
                  name: (e[index].receiver!.id ==
                          profileController.currentUser.value.id
                      ? e[index].sender!.name
                      : e[index].receiver!.name)!,
                  lastChat: e[index].lastMessage ?? "Last Message",
                  lastTime: e[index].lastMessageTimestamp ?? "Last Time",
                ),
              ),
            );
          },
        );
      },
    );
  }
}
