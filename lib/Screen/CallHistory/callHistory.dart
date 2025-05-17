// import 'dart:developer';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:team_talk_flutter_app/utils/color_res.dart';
//
// import '../../utils/assets_res.dart';
// import '../Chat/controller/chatController.dart';
// import '../ProfileScreen/controller/profileController.dart';
//
// class CallHistory extends StatelessWidget {
//   const CallHistory({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     ChatController chatController = Get.put(ChatController());
//     ProfileController profileController = Get.put(ProfileController());
//     // return StreamBuilder(
//     //     stream: chatController.getCalls(),
//     //     builder: (context, snapshot) {
//     //       if (snapshot.hasData) {
//     //         return ListView.builder(
//     //           itemCount: snapshot.data!.length,
//     //           itemBuilder: (context, index) {
//     //             DateTime timestamp =
//     //                 DateTime.parse(snapshot.data![index].timestamp!);
//     //             String formattedTime = DateFormat('hh:mm a').format(timestamp);
//     //             return ListTile(
//     //               leading: ClipRRect(
//     //                   borderRadius: BorderRadius.circular(100),
//     //                   child: CachedNetworkImage(
//     //                     imageUrl: snapshot.data![index].callerUid ==
//     //                             profileController.currentUser.value.id
//     //                         ? snapshot.data![index].receiverPic == null
//     //                             ? assetsRes.defaultProfileUrl
//     //                             : snapshot.data![index].receiverPic!
//     //                         : snapshot.data![index].callerPic == null
//     //                             ? assetsRes.defaultProfileUrl
//     //                             : snapshot.data![index].callerPic!,
//     //                     fit: BoxFit.cover,
//     //                     placeholder: (context, url) =>
//     //                         CircularProgressIndicator(),
//     //                     errorWidget: (context, url, error) => Icon(Icons.error),
//     //                   )),
//     //               title: Text(
//     //                 snapshot.data![index].callerUid ==
//     //                         profileController.currentUser.value.id
//     //                     ? snapshot.data![index].receiverName!
//     //                     : snapshot.data![index].callerName!,
//     //                 style: Theme.of(context).textTheme.bodyMedium,
//     //               ),
//     //               subtitle: Text(
//     //                 formattedTime,
//     //                 style: Theme.of(context).textTheme.labelMedium,
//     //               ),
//     //               trailing: snapshot.data![index].type == "video"
//     //                   ? IconButton(
//     //                       icon: Icon(Icons.video_call),
//     //                       onPressed: () {},
//     //                     )
//     //                   : IconButton(
//     //                       icon: Icon(Icons.call),
//     //                       onPressed: () {},
//     //                     ),
//     //             );
//     //           },
//     //         );
//     //       } else {
//     //         return Center(
//     //           child: Container(
//     //             width: 200,
//     //             height: 200,
//     //             child: CircularProgressIndicator(),
//     //           ),
//     //         );
//     //       }
//     //     });
//     return StreamBuilder(
//       stream: chatController.getCalls(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         if (snapshot.hasData) {
//           final callList = snapshot.data!;
//           if (callList.isEmpty) {
//             // 🟢 No calls to show
//             return Center(
//               child: Text(
//                 "No call history yet",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: colorRes.grey,
//                 ),
//               ),
//             );
//           } else {
//             // 🟢 Show call list
//             return ListView.builder(
//               itemCount: callList.length,
//               itemBuilder: (context, index) {
//                 DateTime timestamp = DateTime.parse(callList[index].timestamp!);
//                 String formattedTime = DateFormat('hh:mm a').format(timestamp);
//                 return ListTile(
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: CachedNetworkImage(
//                       imageUrl: callList[index].callerUid ==
//                               profileController.currentUser.value.id
//                           ? (callList[index].receiverPic?.isNotEmpty ?? false)
//                               ? callList[index].receiverPic!
//                               : assetsRes.defaultProfileUrl
//                           : (callList[index].callerPic?.isNotEmpty ?? false)
//                               ? callList[index].callerPic!
//                               : assetsRes.defaultProfileUrl,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     ),
//                   ),
//                   title: Text(
//                     callList[index].callerUid ==
//                             profileController.currentUser.value.id
//                         ? callList[index].receiverName!
//                         : callList[index].callerName!,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   subtitle: Text(
//                     formattedTime,
//                     style: Theme.of(context).textTheme.labelMedium,
//                   ),
//                   trailing: (callList[index].type?.toLowerCase() == "video")
//                       ? IconButton(
//                           icon: Icon(Icons.video_call),
//                           onPressed: () {
//                             log("CALL TYPE: ${callList[index].type}");
//
//                             // video call code
//                           },
//                         )
//                       : IconButton(
//                           icon: Icon(Icons.call),
//                           onPressed: () {
//                             log("CALL TYPE: ${callList[index].type}");
//
//                             // voice call code
//                           },
//                         ),
//
//                   // trailing: callList[index].type == "video"
//                   //     ? IconButton(
//                   //         icon: Icon(Icons.video_call),
//                   //         onPressed: () {},
//                   //       )
//                   //     : IconButton(
//                   //         icon: Icon(Icons.call),
//                   //         onPressed: () {},
//                   //       ),
//                 );
//               },
//             );
//           }
//         } else if (snapshot.hasError) {
//           return Center(child: Text("Something went wrong"));
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:team_talk_flutter_app/utils/color_res.dart';

import '../../utils/assets_res.dart';
import '../Chat/controller/chatController.dart';
import '../ProfileScreen/controller/profileController.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());

    return StreamBuilder(
      stream: chatController.getCalls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final callList = snapshot.data!;
          if (callList.isEmpty) {
            return Center(
              child: Text(
                "No call history yet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorRes.grey,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: callList.length,
              itemBuilder: (context, index) {
                final call = callList[index];

                // 🕒 Format time
                DateTime timestamp = DateTime.parse(call.timestamp!);
                String formattedTime = DateFormat('hh:mm a').format(timestamp);

                // 📸 Profile image logic
                String imageUrl =
                    call.callerUid == profileController.currentUser.value.id
                        ? (call.receiverPic?.isNotEmpty ?? false)
                            ? call.receiverPic!
                            : assetsRes.defaultProfileUrl
                        : (call.callerPic?.isNotEmpty ?? false)
                            ? call.callerPic!
                            : assetsRes.defaultProfileUrl;

                // 🧠 Determine call type
                String callType = call.type?.toLowerCase() ?? "video";

                log("Call type at index $index: $callType");

                IconData trailingIcon;
                VoidCallback onPressed;

                if (callType == "video") {
                  trailingIcon = Icons.video_call;
                  onPressed = () {
                    print("Start video call to ${call.receiverName}");
                    // TODO: Call video call function here
                  };
                } else {
                  trailingIcon = Icons.call;
                  onPressed = () {
                    print("Start voice call to ${call.receiverName}");
                    // TODO: Call voice call function here
                  };
                }

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  title: Text(
                    call.callerUid == profileController.currentUser.value.id
                        ? call.receiverName!
                        : call.callerName!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    formattedTime,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      trailingIcon,
                      color: callType == "video" ? Colors.purple : Colors.green,
                    ),
                    onPressed: onPressed,
                  ),
                );
              },
            );
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
