import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/ImagePickerBottomSeet.dart';
import '../../utils/color_res.dart';
import '../Groups/NewGroup/model/groupModel.dart';
import '../ProfileScreen/controller/ImagePicker.dart';
import 'controller/groupController.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    GroupController groupController = Get.put(GroupController());
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: messageController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.newline,
            onChanged: (value) {
              message.value = value;
              print("typing...");
              if (value.isNotEmpty) {
                print("typing...");
              } else {
                print("not typing");
              }
            },
            decoration: InputDecoration(
              hintText: "Send Message...",
              // prefixIcon: IconButton(
              //   onPressed: () async {
              //     // final XFile? image = await picker.pickImage(
              //     //     source: ImageSource.gallery);
              //     // if (image != null) {
              //     //   String imageUrl =
              //     //   await uploadImageToFirebase(File(image.path));
              //     //   FireStore_Helper.fireStore_Helper.sendMessage(
              //     //     uid1: data[0],
              //     //     uid2: data[1],
              //     //     msg: imageUrl,
              //     //   );
              //     // }
              //   },
              //   icon: const Icon(
              //     Icons.image,
              //     color: colorRes.grey,
              //   ),
              // ),
              prefixIcon: Obx(
                () => groupController.selectedImagePath.value == ""
                    ? InkWell(
                        onTap: () {
                          ImagePickerBottomSheet(
                              context,
                              groupController.selectedImagePath,
                              imagePickerController);
                        },
                        child: Icon(
                          Icons.image,
                          color: colorRes.grey,
                        ),
                      )
                    : SizedBox(),
              ),
              suffixIcon: Obx(() => InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      groupController.sendGroupMessage(
                        messageController.text,
                        groupModel.id!,
                        "",
                      );
                      messageController.clear();
                      message.value = "";
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: groupController.isLoading.value
                          ? CircularProgressIndicator(
                              color: colorRes.blue,
                            )
                          : Icon(
                              Icons.send,
                              color: colorRes.grey,
                            ),
                    ),
                  )),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          backgroundColor: colorRes.blue,
          foregroundColor: Colors.white,
          onPressed: () {},
          shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.keyboard_voice_rounded),
        ),
      ],
    );
  }
}
