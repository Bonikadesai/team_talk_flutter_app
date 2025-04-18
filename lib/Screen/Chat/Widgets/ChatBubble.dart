import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/text_style.dart';
import '../../../utils/color_res.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isComming;
  final String time;
  final String status;
  final String imageUrl;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isComming,
      required this.time,
      required this.status,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
            isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 1.3,
              ),
              decoration: BoxDecoration(
                color: isComming
                    ? Colors.grey.shade200
                    : colorRes.blue.withOpacity(0.3),
                borderRadius: isComming
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
              ),
              child: imageUrl == ""
                  ? Text(message)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: 200,
                            width: double.infinity,
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: const CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        message == ""
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(message),
                              ),
                      ],
                    )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComming
                  ? Text(
                      time,
                      style: rubikMedium(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  : Row(
                      children: [
                        Text(
                          time,
                          style: rubikMedium(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.done_all,
                          size: 16,
                          color: status == "read" ? Colors.blue : Colors.grey,
                        ),

                        // SvgPicture.asset(
                        //   assetsRes.chatStatusSvg,
                        //   color: status == "read" ? colorRes.blue : Colors.grey,
                        //   width: 20,
                        // )
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}
