import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:team_talk_flutter_app/firebase_options.dart';
import 'package:team_talk_flutter_app/utils/string_res.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'Screen/SplashScreen/splashScreen.dart';
import 'common/routs.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void _initializeFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission();

  // Get the FCM token
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received a message: ${message.notification?.title}");
    // Show notification or handle logic here
  });

  // Handle when app is in background or terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Opened from background: ${message.notification?.title}");
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZegoUIKit().init(
    appID: ZegoCloudConfig.appId,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FCMConfig.instance.init(
  //     defaultAndroidForegroundIcon:
  //         '@mipmap/ic_launcher', //default is @mipmap/ic_launcher
  //     defaultAndroidChannel: AndroidNotificationChannel(
  //       'high_importance_channel', // same as value from android setup
  //       'Fcm config',
  //       importance: Importance.high,
  //       sound: RawResourceAndroidNotificationSound('notification'),
  //     ),
  //     onBackgroundMessage: _firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await NotificationService().init();
  // _initializeFCM();
  runApp(const MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Background Message: ${message.messageId}");
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
      getPages: routes,
      themeMode: ThemeMode.dark,
      title: 'Team Talk',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
