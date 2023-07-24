import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilPetugasController extends GetxController {
  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  //? Text Field Controller //
  TextEditingController emailPetugasC = TextEditingController();
  TextEditingController namaPetugasC = TextEditingController();

  //? Stream Petugas //
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPetugas() async* {
    String email = auth.currentUser!.email!;
    yield* db.collection('users').doc(email).snapshots();
  }
}
