// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;

class ProfilWargaController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController rtC = TextEditingController();
  TextEditingController rwC = TextEditingController();
  TextEditingController waC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  s.FirebaseStorage media = s.FirebaseStorage.instance;
  File? imageProfil;
  String? extImageProfil;

  //?Read User Data//
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String email = auth.currentUser!.email!;
    yield* db.collection('users').doc(email).snapshots();
  }

  //?Update User Data//
  Future<void> updateProfile(String email) async {
    isLoading.value = true;
    if (emailC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        rtC.text.isNotEmpty &&
        rwC.text.isNotEmpty &&
        waC.text.isNotEmpty) {
      try {
        await db.collection('users').doc(email).update({
          'nama_lengkap': namaC.text,
          'rt': rtC.text,
          'rw': rwC.text,
          'no_wa': waC.text,
          //'foto_profil': imageUrl
        });
        isLoading.value = false;
        Get.snackbar("Berhasil", "Data berhasil diupdate",
            backgroundColor: appSuccess, snackPosition: SnackPosition.TOP);
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Gagal", "Data gagal diupdate",
            backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
      }
    }
  }
}
