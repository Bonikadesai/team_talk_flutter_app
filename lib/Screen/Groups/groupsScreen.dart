import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/utils/color_res.dart';

import '../../utils/assets_res.dart';
import '../GroupChat/controller/groupController.dart';
import '../GroupChat/groupChat.dart';
import '../Home/Widget/ChatTile.dart';
import 'NewGroup/model/groupModel.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return StreamBuilder<List<GroupModel>>(
      stream: groupController.getGroupss(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<GroupModel>? groups = snapshot.data;
        return groups == null || groups.isEmpty
            ? Center(
                child: Text(
                "Create a new group to start chatting",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorRes.grey),
              ))
            : ListView.builder(
                itemCount: groups!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(GroupChatPage(groupModel: groups[index]));
                    },
                    child: ChatTile(
                      name: groups[index].name!,
                      imageUrl: groups[index].profileUrl == ""
                          ? assetsRes.defaultProfileUrl
                          : groups[index].profileUrl!,
                      lastChat: "Group Created",
                      lastTime: "Just Now",
                    ),
                  );
                },
              );
      },
    );
  }
}
