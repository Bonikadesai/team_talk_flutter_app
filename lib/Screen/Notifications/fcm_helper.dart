import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Api_Helper {
  Api_Helper._();

  static final Api_Helper api_helper = Api_Helper._();

  sendNotification() async {
    String FCM_API = "https://fcm.googleapis.com/fcm/send";
    var myHeaders = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAA57p6LZs:APA91bFOcruk6Wc8RumKQxeD8M6H_N8_7QbsiVYJp3KqRLnZxzC_fUNSYSw4D1y7Yr_XDFX_BNfJydu1hRQy2iiAqp3SV5i2jaoGkLaMikMrnUFqBm5AWJ1ROTmFbN8AsTYfmhxKhGbg"
    };
    var myBody = {
      "to":
          "fpc6Fl1tRHWv342LVqvfjH:APA91bEWl9xNIh3hQxxWZDgwu2MBBU5NX85e2kc4V9oyKBDXGEn642f0GglEzBbqfwQ35IqhT7QrO7wcpT_PlynoEFV9r_Lypc_HGB_eih4FfYmBm-D4ChCLgV_IYPXsfUt8cLrBYpXq",
      "notification": {
        "body": "Good mornings..",
        "OrganizationId": "2",
        "content_available": true,
        "priority": "high",
        "subtitle": "Elementary School",
        "title": "Chat App"
      },
      "data": {
        "priority": "high",
        "sound": "app_sound.wav",
        "content_available": true,
        "bodyText": "New Announcement assigned",
        "organization": "Elementary school"
      }
    };
    http.Response response = await http.post(Uri.parse(FCM_API),
        headers: myHeaders, body: jsonEncode(myBody));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      if (decodedData['success'] == 1) {
        log("==========================================");
        log("Notification Sent Successfully");
        log("==========================================");
      } else if (decodedData['success'] == 0) {
        log("==========================================");
        log("Notification Failed.......");
        log("==========================================");
      }
    }
  }
}
