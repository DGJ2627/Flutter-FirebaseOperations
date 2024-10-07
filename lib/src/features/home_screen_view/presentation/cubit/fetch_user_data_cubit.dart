import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebasae_push_notification_2/src/core/utils/log/logger.dart';
import 'package:firebasae_push_notification_2/src/features/home_screen_view/domain/model/user_data_firebase_store_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import '../../data/service/push_notification.dart';

part 'fetch_user_data_state.dart';

class FetchUserDataCubit extends Cubit<FetchUserDataState> {
  FetchUserDataCubit() : super(FetchUserDataInitial());

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return FirebaseFirestore.instance.collection('userData').snapshots();
  }

  Future<String> getAccessToken() async {
    final accountCredentials = ServiceAccountCredentials.fromJson(
      json.decode(await rootBundle.loadString('asset/notification.json')),
    );

    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    final client = await clientViaServiceAccount(accountCredentials, scopes);

    final accessToken = client.credentials.accessToken;

    client.close();
    return accessToken.data;
  }

  Future<void> sendMessageNotification(
    String body,
    String title,
    String userId,
  ) async {
    try {
      final accessToken = await getAccessToken();

      String? token = await FirebaseMessaging.instance.getToken();
      await FirebaseMessaging.instance.subscribeToTopic('all');

      if (token != null) {
        final payload = {
          "message": {
            // "topic": "all",
            "token": token,
            "notification": {
              "title": title,
              "body": body,
            },
            "data": {
              "userId": userId,
              "type": "notification",
            }
          }
        };

        final response = await http.post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/flutter-firebase-operati-b9101/messages:send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(payload),
        );

        if (response.statusCode == 200) {
          Log.success("Notification sent successfully!");
        } else {
          Log.error("Error sending notification: ${response.statusCode}");
        }
      } else {
        Log.error("User FCM Token is null");
      }
    } catch (e) {
      Log.error("Error sending message: $e");
    }
  }

  Future<void> sendFCMNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      MyFirebaseMessagingService.backgroundHandler(message);
    });

    FirebaseMessaging.onBackgroundMessage(
      (RemoteMessage message) {
        return MyFirebaseMessagingService.backgroundHandler(message);
      },
    );

    FirebaseMessaging.onBackgroundMessage(
      (RemoteMessage message) {
        return MyFirebaseMessagingService.backgroundHandler(message);
      },
    );
  }
}
