// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:aplikasi_sampah/main.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? mToken = "";

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
    playSound: true,
    showBadge: true,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    Get.toNamed(AppLinks.REQUEST_PENGAMBILAN, arguments: message);
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/launcher_icon');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings,
        onSelectNotification: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload!));
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  priority: Priority.high,
                  playSound: true,
                  importance: Importance.high,
                  icon: '@drawable/launcher_icon')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotifcations() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    saveToken(fCMToken.toString());
    initPushNotifications();
    initLocalNotifications();
  }

  void saveToken(String token) async {
    await db.collection("users").doc(auth.currentUser!.email).update({
      "token": token,
    });
  }

  void sendPushMessage(String token, String title, String body) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAmi4lr0s:APA91bFpe8KJuHPn1fjx5Y7m8zL7x-_cl7I3tWLKp5MPznOKX4YbHISXtANy-w_ve7vZW7WAQrasuneTi5yxoI8M1zMLCERPeem-FSq78goXRH94FftdL2ZkZxMZyC3useolnPZyFTiq'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "high_importance_channel"
            },
            "to": token,
          }));
      print("Token: $token");
      print("Title: $title");
      print("Body: $body");
    } catch (e) {
      if (kDebugMode) {
        print("Error Push Send Notif...");
      }
    }
  }
}
