import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ImagePickerBottomSeet.dart';
import '../../../utils/color_res.dart';
import '../../ProfileScreen/controller/ImagePicker.dart';
import '../controller/chatController.dart';
import '../model/userModel.dart';

class TypeMessage extends StatelessWidget {
  final UserModel userModel;
  const TypeMessage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
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
                () => chatController.selectedImagePath.value == ""
                    ? InkWell(
                        onTap: () {
                          ImagePickerBottomSheet(
                              context,
                              chatController.selectedImagePath,
                              imagePickerController);
                        },
                        child: Icon(
                          Icons.image,
                          color: colorRes.grey,
                        ),
                      )
                    : SizedBox(),
              ),
              // prefixIcon: Obx(
              //   () => InkWell(
              //     onTap: () {
              //       ImagePickerBottomSheet(
              //         context,
              //         chatController.selectedImagePath,
              //         imagePickerController,
              //       );
              //     },
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         Icon(
              //           Icons.image,
              //           color: colorRes.grey,
              //         ),
              //         // if (chatController.selectedImagePath.value.isNotEmpty)
              //         //   Positioned(
              //         //     right: 0,
              //         //     top: 0,
              //         //     child: Container(
              //         //       padding: EdgeInsets.all(2),
              //         //       decoration: BoxDecoration(
              //         //         color: Colors.blue,
              //         //         shape: BoxShape.circle,
              //         //       ),
              //         //       child: Icon(
              //         //         Icons.check,
              //         //         size: 12,
              //         //         color: Colors.white,
              //         //       ),
              //         //     ),
              //         //   ),
              //       ],
              //     ),
              //   ),
              // ),
              suffixIcon: Obx(
                () => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (messageController.text.isNotEmpty ||
                        chatController.selectedImagePath.value.isNotEmpty) {
                      // Null check before using the id
                      if (userModel.id != null) {
                        chatController.sendMessage(
                            userModel.id!, messageController.text, userModel,
                            imagePath: chatController.selectedImagePath.value,context: context);
                        messageController.clear();
                        message.value = "";
                      } else {
                        print("User ID is null");
                      }
                    }
                    // if (messageController.text.isNotEmpty ||
                    //     chatController.selectedImagePath.value.isNotEmpty) {
                    //   chatController.sendMessage(
                    //       userModel.id!, messageController.text, userModel);
                    //   messageController.clear();
                    //   message.value = "";
                    // }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: chatController.isLoading.value
                        ? CircularProgressIndicator(
                            color: colorRes.blue,
                          )
                        : Icon(
                            Icons.send,
                            color: colorRes.grey,
                          ),
                  ),
                ),
              ),
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
