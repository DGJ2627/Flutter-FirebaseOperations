import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';

class RequestNotificationPermission {
  static void requestForNotification() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      const SizedBox(
        height: 100,
        width: 100,
        child: AlertDialog(
          title: Text("user granted permission"),
        ),
      );
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      const SizedBox(
        height: 100,
        width: 100,
        child: AlertDialog(
          title: Text("user granted permission"),
        ),
      );
    } else {
      const SizedBox(
        height: 100,
        width: 100,
        child: AlertDialog(
          title: Text("permission denied"),
          content: Text("allow permission "),
        ),
      );
      Future.delayed(
        const Duration(seconds: 2),
        () {
          AppSettings.openAppSettings(type: AppSettingsType.notification);
        },
      );
    }
  }

  static Future<String> getDeviceToken() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
    );

    String? token = await message.getToken();
    print("==================");
    print(token);
    print("==================");
    return token!;
  }
}
