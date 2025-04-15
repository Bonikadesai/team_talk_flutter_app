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
            child: Obx(() => ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final isUser = msg['role'] == 'user';
                    return Container(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      margin: EdgeInsets.all(8),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(msg['content'] ?? ''),
                      ),
                    );
                  },
                )),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: inputController,
                  decoration: InputDecoration(hintText: "Type a message..."),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  final text = inputController.text.trim();
                  if (text.isNotEmpty) {
                    controller.sendMessage(text);
                    inputController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
