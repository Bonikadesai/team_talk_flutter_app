import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:team_talk_flutter_app/Screen/Chat/model/ChatRoomModel.dart';

import '../model/ChatModel.dart';
import '../model/userModel.dart';

import 'package:http/http.dart' as http;

class ChatNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Important Notification",
      importance: Importance.max,
    );

    print('channel id:${channel.id.toString()}');
    print('channel name:${channel.name.toString()}');

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Your Channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      icon: '@mipmap/ic_launcher',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? "Notification",
        message.notification?.body ?? "Message Body",
        notificationDetails);
  }

// Function to trigger notification on button press
  Future<void> triggerNotification(BuildContext context,
      {String? message,
      UserModel? user,
      ChatModel? chatModel,
      ChatRoomModel? roomDetails}) async {
    print('chatModel :$chatModel');
    print('roomDetails :$roomDetails');
    // await sendNotificationByToken(
    //     "f6VUtS41T6GVjvypemarU2:APA91bFXuvIP1t3afaqvM_xV3grdqruYgVj0gD9_zYEG5wawkxYBCIZfOmQmDnNBhOmZBkfn9DPdfnrn4dDNftiL0FjXfMLCt13R-TK7i3tS3TjTZwyz_rY",
    //     (chatModel?.senderName ?? ""),
    //     (message?.isNotEmpty ?? false) ? message ?? "Image" : "Image");

    // await sendNotificationByToken();
    // Listen for foreground messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Received a message: ${message.notification?.title}");
    //   // Show notification or handle logic here
    // });
    RemoteMessage mockMessage = RemoteMessage(
      notification: RemoteNotification(
        title: chatModel?.senderName,
        body: (message?.isNotEmpty ?? false) ? message : "Image",
      ),
      data: {'type': 'test'},
    );
    showNotification(mockMessage);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Received a message: ${message.notification?.title}");
    //   showNotification(message);
    //   // Show notification or handle logic here
    // });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  Future<void> sendNotificationByToken(
      String token, String title, String body) async {
    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/team-talk-flutter-app/messages:send');

    final headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'key=$serverKey',
    };

    final bodyData = json.encode({
      "message": {
        "token": token,
        "notification": {"body": title, "title": body}
      }
    });

    final response = await http.post(url, headers: headers, body: bodyData);

    if (response.statusCode == 200) {
      print("Notification sent successfully!");
    } else {
      print(
          "Failed to send notification. Response code: ${response.statusCode}");
    }
  }
}
