import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/assets_res.dart';
import '../../../utils/color_res.dart';
import '../../GroupChat/controller/groupController.dart';
import '../../Home/Widget/ChatTile.dart';
import '../../ProfileScreen/controller/ImagePicker.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    RxString groupName = "".obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorRes.blue,
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        title: Text('New Group'),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          backgroundColor:
              groupName.isEmpty ? Colors.grey.shade300 : colorRes.blue,
          onPressed: () {
            if (groupName.isEmpty) {
              Get.snackbar("Error", "Please enter group name",
                  backgroundColor: Colors.red, colorText: Colors.white);
            } else {
              groupController.createGroup(groupName.value, imagePath.value);
            }
          },
          child: groupController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(
                  Icons.done,
                  color: Colors.white,
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Obx(
                          () => InkWell(
                            onTap: () async {
                              imagePath.value = await imagePickerController
                                  .pickImage(ImageSource.gallery);
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: colorRes.blue,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: imagePath.value == ""
                                  ? const Icon(
                                      Icons.group,
                                      size: 40,
                                      color: Colors.white,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        File(imagePath.value),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            groupName.value = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Group Name",
                            prefixIcon: Icon(Icons.group),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: groupController.groupMembers
                      .map(
                        (e) => ChatTile(
                            imageUrl:
                                e.profileImage ?? assetsRes.defaultProfileUrl,
                            name: e.name!,
                            lastChat: e.about ?? '',
                            lastTime: ""),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
