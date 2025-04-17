import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../model/userModel.dart';

class ChatNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  requestNotification() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        print("payload");
      },
    );
  }

  void firebaseInit(BuildContext context) {
    print("call firebaseInit");
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print(event.notification?.title);
        print(event.data["type"]);
      }
      if (Platform.isIOS) {
        forGroundMessage();
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, event);
        showNotification(event);
      }
    });
  }

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
  void triggerNotification(BuildContext context,
      {String? message, UserModel? user}) {
    RemoteMessage mockMessage = RemoteMessage(
      notification: RemoteNotification(
        title: user?.name,
        body: message,
      ),
      data: {'type': 'test'},
    );
    showNotification(mockMessage);
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  Future forGroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  isRefreshToken() {
    messaging.onTokenRefresh.listen((event) {
      print("refresh");
      event.toString();
    });
  }
}
