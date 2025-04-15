import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/text_style.dart';
import '../../../utils/assets_res.dart';
import '../../../utils/color_res.dart';
import '../../ContactScreen/controller/contactController.dart';
import '../../GroupChat/controller/groupController.dart';
import '../../Home/Widget/ChatTile.dart';
import 'groupTitle.dart';
import 'selectedMemberList.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: Text('New Group'),
        foregroundColor: Colors.white,
        backgroundColor: colorRes.blue,
        toolbarHeight: 100,
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          backgroundColor: groupController.groupMembers.isEmpty
              ? Colors.grey.shade400
              : colorRes.blue,
          onPressed: () {
            if (groupController.groupMembers.isEmpty) {
              Get.snackbar("Error", "Please select atleast one member",
                  backgroundColor: Colors.red, colorText: Colors.white);
            } else {
              Get.to(GroupTitle());
            }
          },
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SelectedMembers(),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Contacts on Chatterly",
                  style: rubikMedium(color: colorRes.blue, fontSize: 22),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: contactController.getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text("No Messages"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            groupController.selectMember(snapshot.data![index]);
                          },
                          child: ChatTile(
                            imageUrl: snapshot.data![index].profileImage ??
                                assetsRes.defaultProfileUrl,
                            name: snapshot.data![index].name!,
                            lastChat: snapshot.data![index].about ?? "",
                            lastTime: "",
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
