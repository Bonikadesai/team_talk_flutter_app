import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/common/text_style.dart';

import '../../../utils/color_res.dart';
import '../../Chat/controller/chatController.dart';

class ChatTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastChat;
  final String lastTime;
  final String unReadMessageCount;
  const ChatTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.lastChat,
      required this.lastTime,
      this.unReadMessageCount = "0"});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: 70,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: rubikMedium(
                            fontSize: 18,
                            color: colorRes.blue,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        lastChat,
                        maxLines: 1,
                        style: rubikRegular(fontSize: 14, color: colorRes.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              // StreamBuilder(
              //   stream: chatController.getUnreadMessageCount(
              //       "Mp6yiJWt2RWzK5DFPZmroN843xX29SjvS2o0BJfBa80D2CWh2SgazMi1"),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData && snapshot.data == 0) {
              //       return Container();
              //     }
              //     return Container(
              //       width: 20,
              //       height: 20,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //         color: Theme.of(context).colorScheme.primary,
              //       ),
              //       child: Center(
              //         child: Text(
              //           snapshot.data.toString(),
              //           style: Theme.of(context)
              //               .textTheme
              //               .labelMedium
              //               ?.copyWith(
              //                 color: Theme.of(context).colorScheme.onBackground,
              //               ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              Text(
                lastTime,
                style: rubikMedium(
                    fontSize: 14,
                    color: colorRes.blue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
