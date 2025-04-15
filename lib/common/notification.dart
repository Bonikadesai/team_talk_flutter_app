import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await _fcm.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          //_showLocalNotification(notification);
        }
      });
    }

    // Get FCM token
    String? token = await _fcm.getToken();
    print("FCM Token: $token");
  }
  //
  // void _showLocalNotification(RemoteNotification notification) async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('chat_channel', 'Chat Notifications');
  //
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     notification.title,
  //     notification.body,
  //     platformChannelSpecifics,
  //   );
  // }
}
