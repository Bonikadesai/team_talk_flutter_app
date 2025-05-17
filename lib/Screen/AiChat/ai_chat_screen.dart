import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/Screen/AiChat/controller/ai_chat_controller.dart';
import 'package:team_talk_flutter_app/common/text_style.dart';
import 'package:team_talk_flutter_app/utils/color_res.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final AIChatController controller = Get.put(AIChatController());
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: colorRes.blue,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            //  Get.to(UserProfileScreen(userModel: userModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset("assets/Icons/ai profile.svg"),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // Get.to(UserProfileScreen(userModel: userModel));
          },
          child: Row(
            children: [
              Text("TeamTalk AI",
                  style: rubikMedium(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                // Check if there are any messages
                if (controller.messages.isEmpty) {
                  return Center(
                    child: Text(
                      "I'm ready when you are. Just type and send!",
                      style: rubikMedium(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colorRes.grey,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      final isUser = msg['role'] == 'user';
                      return Container(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        margin: EdgeInsets.all(8),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? colorRes.blue.withOpacity(0.3)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(msg['content'] ?? ''),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: inputController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.newline,
                    onChanged: (value) {
                      print("typing...");
                      if (value.isNotEmpty) {
                        print("typing...");
                      } else {
                        print("not typing");
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Send Message...",
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: colorRes.grey,
                          ),
                          onPressed: () {
                            final text = inputController.text.trim();
                            if (text.isNotEmpty) {
                              controller.sendMessage(text);
                              inputController.clear();
                            }
                          },
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
              ],
            ),
          ),
        ],
      ),

      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Obx(() => ListView.builder(
      //             itemCount: controller.messages.length,
      //             itemBuilder: (context, index) {
      //               final msg = controller.messages[index];
      //               final isUser = msg['role'] == 'user';
      //               return Container(
      //                 alignment:
      //                     isUser ? Alignment.centerRight : Alignment.centerLeft,
      //                 margin: EdgeInsets.all(8),
      //                 child: Container(
      //                   padding: EdgeInsets.all(12),
      //                   decoration: BoxDecoration(
      //                     color: isUser
      //                         ? colorRes.blue.withOpacity(0.3)
      //                         : Colors.grey.shade200,
      //                     borderRadius: BorderRadius.circular(12),
      //                   ),
      //                   child: Text(msg['content'] ?? ''),
      //                 ),
      //               );
      //             },
      //           )),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             flex: 4,
      //             child: TextFormField(
      //               controller: inputController,
      //               keyboardType: TextInputType.text,
      //               textInputAction: TextInputAction.newline,
      //               onChanged: (value) {
      //                 //message.value = value;
      //                 print("typing...");
      //                 if (value.isNotEmpty) {
      //                   print("typing...");
      //                 } else {
      //                   print("not typing");
      //                 }
      //               },
      //               decoration: InputDecoration(
      //                 hintText: "Send Message...",
      //                 //  prefixIcon: Obx(
      //                 //  () => chatController.selectedImagePath.value == ""
      //                 //  ? InkWell(
      //                 //  onTap: () {
      //                 //  ImagePickerBottomSheet(
      //                 //  context,
      //                 // // chatController.selectedImagePath,
      //                 //  //imagePickerController
      //                 //  );
      //                 //  },
      //                 //  child: Icon(
      //                 //  Icons.image,
      //                 //  color: colorRes.grey,
      //                 //  ),
      //                 //  )
      //                 //      : SizedBox(),
      //                 //  ),
      //                 suffixIcon: InkWell(
      //                   splashColor: Colors.transparent,
      //                   highlightColor: Colors.transparent,
      //                   onTap: () {},
      //                   child: IconButton(
      //                     // width: 30,
      //                     // height: 30,
      //                     icon: Icon(
      //                       Icons.send,
      //                       color: colorRes.grey,
      //                     ),
      //                     onPressed: () {
      //                       final text = inputController.text.trim();
      //                       if (text.isNotEmpty) {
      //                         controller.sendMessage(text);
      //                         inputController.clear();
      //                       }
      //                     },
      //                   ),
      //                 ),
      //                 filled: true,
      //                 fillColor: Colors.white,
      //                 border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(30),
      //                   borderSide: BorderSide.none,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     // Row(
      //     //   children: [
      //     //     Expanded(
      //     //       child: TextField(
      //     //         controller: inputController,
      //     //         decoration: InputDecoration(hintText: "Type a message..."),
      //     //       ),
      //     //     ),
      //     //     IconButton(
      //     //       icon: Icon(Icons.send),
      //     //       onPressed: () {
      //     //         final text = inputController.text.trim();
      //     //         if (text.isNotEmpty) {
      //     //           controller.sendMessage(text);
      //     //           inputController.clear();
      //     //         }
      //     //       },
      //     //     ),
      //     //   ],
      //     // ),
      //   ],
      // ),
    );
  }
}
