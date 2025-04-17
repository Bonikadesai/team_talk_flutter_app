import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/AiChat/ai_chat_screen.dart';
import 'package:team_talk_flutter_app/Screen/Notifications/notification.dart';

import '../../utils/color_res.dart';
import '../../utils/string_res.dart';
import '../Auth/controller/authController.dart';
import '../CallHistory/CallHistory.dart';
import '../CallScreen/controller/callController.dart';
import '../Chat/controller/StatusController.dart';
import '../ContactScreen/controller/contactController.dart';
import '../Groups/groupsScreen.dart';
import '../ProfileScreen/ProfileScreen.dart';
import '../ProfileScreen/controller/ImagePicker.dart';
import '../ProfileScreen/controller/profileController.dart';
import 'Widget/ChatsList.dart';
import 'Widget/TabBar.dart';
import 'controller/AppConntroller.dart';

ValueNotifier<bool> isShowSearchField = ValueNotifier(false);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 5, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    StatusController statusController = Get.put(StatusController());
    CallController callController = Get.put(CallController());
    AppController appController = Get.put(AppController());
    AuthController authController = Get.put(AuthController());

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorRes.blue,
          foregroundColor: Colors.white,
          title: const Text(stringRes.appName),
          toolbarHeight: 100,
          actions: [
            IconButton(
              onPressed: () {
                if (tabController.index == 0) {
                  isShowSearchField.value = !isShowSearchField.value;

                  log('isShowSearchField :$isShowSearchField');
                } else {
                  isShowSearchField.value = false;
                  contactController.searchController.clear();
                  tabController.index = 0;
                }
                appController.checkLatestVersion();
              },
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(AiChatScreen());
              },
              icon: SvgPicture.asset("assets/Icons/ai chat.svg",
                  height: 22, width: 22),
            ),
            // SvgPicture.asset("assets/Icons/ai chat.svg"),
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //             title: const Text("Are You Sure?"),
            //             content: const Text("Do you want to logout?"),
            //             actions: [
            //               ElevatedButton(
            //                 onPressed: () {
            //                   AuthHelper.authHelper
            //                       .logoutUser(); // Sign out the user
            //                 },
            //                 child: const Text("Yes"),
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {
            //                   Get.to(HomeScreen()); // Close the dialog
            //                 },
            //                 child: const Text("No"),
            //               ),
            //             ]);
            //       },
            //     );
            //   },
            //   icon: const Icon(Icons.logout),
            // )
          ],
        ),
        bottomNavigationBar: myTabBar(tabController, context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/contactPage");
          },
          foregroundColor: Colors.white,
          backgroundColor: colorRes.blue,
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          child: const Icon(
            Icons.add,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            controller: tabController,
            children: [
              ChatList(),
              GroupScreen(),
              CallHistory(),
              ProfileScreen(),
              Notification_Screen(),
            ],
          ),
        ),
      ),
    );
  }
}
