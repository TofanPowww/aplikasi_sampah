// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? mToken = "";

  Future<void> initNotifcations() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    saveToken(fCMToken.toString());
  }

  void saveToken(String token) async {
    await db.collection("users").doc(auth.currentUser!.email).update({
      "token": token,
    });
  }
}
