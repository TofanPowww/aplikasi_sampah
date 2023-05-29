import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/routes/links.dart';

class ProfilController extends GetxController {
  //? Routing //
  toProfilSaya() => Get.toNamed(AppLinks.PROFIL_SAYA);
  toProfilAdmin() => Get.toNamed(AppLinks.PROFIL_ADMIN);
  toProfilPetugas() => Get.toNamed(AppLinks.PROFIL_PETUGAS);
  toResetPassword() => Get.toNamed(AppLinks.PROFIL_RESET);

  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //? Stream Data Role User //
  Stream<DocumentSnapshot<Map<String, dynamic>>> roleUser() async* {
    String? email = auth.currentUser!.email;
    yield* firestore.collection("users").doc(email).snapshots();
  }
}
