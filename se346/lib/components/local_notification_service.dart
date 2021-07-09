import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

final String serverToken = "AAAAg2EwN9A:APA91bF2ypqwR8qqCKtrNZL6_uoBa8d66NoehJZK8zXX6QtE5k6bzock538LTk4f03R5H_ccIft6IfQh9v1eAsjpByqUTPsqLsSOTlD5o4Yw4ZhCx-yU9r_g41k0xg3pyQ-eQbsAZgGe";

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initalize(){
    final InitializationSettings initializationSettings =
      InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> display(RemoteMessage message) async {

    try {
      final id = DateTime.now().microsecond ~/1000;

      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "testNoti",
          "testNoti channel",
          "this our app",
          importance: Importance.max,
          priority: Priority.high,
        )
      );

      await _notificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails
      );
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}

Future<void> sendPushMessage(String _token, String title, String body) async {
  if (_token == null) {
    print('Unable to send FCM message, no token exists.');
    return;
  }

  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),//https://fcm.googleapis.com/v1/projects/e-commerce-app-f6fa8/messages:send
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: constructFCMPayload(_token, title, body)
    ).whenComplete(() => print('FCM request for device sent!'));

  } catch (e) {
    print(e);
  }
}

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token, String title, String body) {
  return jsonEncode(
      {
          "to": token,
          "data":{},
          "notification": {
            "title":title,
            "body":body,
          }
      });
}

String constructFCMPayload1(String token, String title, String body) {
  return jsonEncode(
      {
        "to": token,
        "data":{},
        "notification": {
          "title":title,
          "body":body,
        }
      });
}