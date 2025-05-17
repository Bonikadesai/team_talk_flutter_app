import 'package:flutter/material.dart';

import '../../../utils/color_res.dart';

myTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    // child: BottomNavigationBar(
    //   backgroundColor: colorRes.blue,
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.grey.shade500,
    //   items: const [
    //     BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
    //     BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
    //     BottomNavigationBarItem(icon: Icon(Icons.person_2), label: "Profile"),
    //   ],
    // ),
    child: TabBar(
      controller: tabController,
      indicatorWeight: 4,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: colorRes.blue,
      labelStyle: TextStyle(color: colorRes.blue),
      unselectedLabelStyle: TextStyle(color: colorRes.grey),
      tabs: const [
        Tab(
          icon: Icon(Icons.chat),
          text: "Chats",
        ),
        Tab(
          icon: Icon(Icons.group),
          text: "Groups",
        ),
        Tab(
          icon: Icon(Icons.call),
          text: "Calls",
        ),
        Tab(
          icon: Icon(Icons.person),
          text: "Profile",
        ),
      ],
    ),
  );
}
