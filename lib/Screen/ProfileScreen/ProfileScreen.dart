import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_talk_flutter_app/utils/color_res.dart';

import '../../common/PrimaryButton.dart';
import '../Auth/controller/authController.dart';
import 'controller/ImagePicker.dart';
import 'controller/profileController.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController name =
        TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController email =
        TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phone = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController about =
        TextEditingController(text: profileController.currentUser.value.about);
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;

    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              // height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        imagePath.value =
                                            await imagePickerController
                                                .pickImage(ImageSource.gallery);
                                        print("Image Picked" + imagePath.value);
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: colorRes.blue,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: imagePath.value == ""
                                            ? Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.file(
                                                  File(imagePath.value),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    )
                                  : Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: colorRes.blue,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: profileController.currentUser.value
                                                      .profileImage ==
                                                  null ||
                                              profileController.currentUser
                                                      .value.profileImage ==
                                                  ""
                                          ? Icon(
                                              Icons.image,
                                              color: Colors.white,
                                              size: 40,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: profileController
                                                    .currentUser
                                                    .value
                                                    .profileImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )),
                                    ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => TextField(
                            controller: name,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: isEdit.value,
                              labelText: "Name",
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: about,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: isEdit.value,
                              labelText: "About",
                              prefixIcon: Icon(
                                Icons.info,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: email,
                          enabled: false,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade300,
                            filled: isEdit.value,
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.alternate_email,
                            ),
                          ),
                        ),
                        Obx(
                          () => TextField(
                            controller: phone,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade300,
                              filled: isEdit.value,
                              labelText: "Number",
                              prefixIcon: Icon(
                                Icons.phone,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? PrimaryButton(
                                      btnName: "Save",
                                      icon: Icons.save,
                                      ontap: () async {
                                        await profileController.updateProfile(
                                          imagePath.value,
                                          name.text,
                                          about.text,
                                          phone.text,
                                        );
                                        isEdit.value = false;
                                      },
                                    )
                                  : PrimaryButton(
                                      btnName: "Edit",
                                      icon: Icons.edit,
                                      ontap: () {
                                        isEdit.value = true;
                                      },
                                    ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
