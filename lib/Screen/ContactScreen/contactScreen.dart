import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/text_style.dart';
import '../../utils/assets_res.dart';
import '../../utils/color_res.dart';
import '../Chat/chatScreen.dart';
import '../Chat/controller/chatController.dart';
import '../Groups/NewGroup/newGroup.dart';
import '../Home/Widget/ChatTile.dart';
import '../ProfileScreen/controller/profileController.dart';
import 'Widgets/ConactSearch.dart';
import 'Widgets/NewContatcTile.dart';
import 'controller/contactController.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select contact"),
        backgroundColor: colorRes.blue,
        foregroundColor: Colors.white,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon:
                  isSearchEnable.value ? Icon(Icons.close) : Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value ? ContactSearch() : SizedBox(),
            ),
            //  SizedBox(height: 10),
            // NewContactTile(
            //   btnName: "New contact",
            //   icon: Icons.person_add,
            //   ontap: () {},
            // ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontap: () {
                Get.to(NewGroup());
              },
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Contacts on Chatterly",
                  style: rubikMedium(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children: contactController.userList
                    .map(
                      (e) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.to(ChatPage(userModel: e));
                        },
                        child: ChatTile(
                          imageUrl:
                              e.profileImage ?? assetsRes.defaultProfileUrl,
                          name: e.name ?? "User",
                          lastChat: e.about ?? "Hey there",
                          lastTime: e.email ==
                                  profileController.currentUser.value.email
                              ? "You"
                              : "",
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
