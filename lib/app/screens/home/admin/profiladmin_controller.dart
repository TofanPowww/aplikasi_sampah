import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilAdminController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController emailAdminC = TextEditingController();
  TextEditingController namaAdminC = TextEditingController();

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamAdmin() async* {
    String email = auth.currentUser!.email!;
    yield* db.collection('users').doc(email).snapshots();
  }
}
