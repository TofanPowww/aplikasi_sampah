// ignore_for_file: avoid_print

import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/service/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KirimController extends GetxController {
  var isLoading = false.obs;
  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //? TextField Controller //
  final formKey = GlobalKey<FormState>();
  final AuthController authC = Get.put(AuthController());
  TextEditingController nama = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  //? Image Picker Controller //
  File? foto;
  String? imageUrl;

  //? Value dari Dropdown Menu //
  var statusOption = ['Diterima', 'Menunggu', 'Ditolak'];
  var currentStatusSelected = "Menunggu";
  var status = "Menunggu";

  //? Stream User //
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String? email = auth.currentUser!.email;
    yield* db.collection('users').doc(email).snapshots();
  }

  Future<QuerySnapshot> petugas() async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('rool', isEqualTo: 'Petugas')
        .get();
  }

  //? Menyimpan Transaksi Kirim Sampah //
  Future<void> addNewKirim(
      String nama, String rt, String rw, String tgl) async {
    isLoading.value = true;
    User? users = auth.currentUser;
    try {
      CollectionReference usersDB = db.collection("users");
      CollectionReference transaksiDB = db.collection("transaksiSampah");

      final kirimU = usersDB.doc(auth.currentUser!.email).collection("kirim");

      //* Menyimpan Foto Sampah ke Firebase Storage //
      final ref = FirebaseStorage.instance
          .ref()
          .child('foto_data_sampah')
          .child('Kirim_${tgl}jpg');
      await ref.putFile(foto!);
      imageUrl = await ref.getDownloadURL();

      //* Menambah Nested Collection Kirim pada Collection User//
      final dataKirim = await kirimU.add({
        "tgl": tgl,
        "foto_sampah": imageUrl,
        "jumlahOrganik": 0.0,
        "jumlahAnorganik": 0.0,
        "poin": 0,
        "status": status,
        "creationTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });

      //* Menambah Transaksi Sampah //
      await transaksiDB.doc(dataKirim.id).set({
        "id": dataKirim.id,
        "email": users!.email,
        "nama": nama,
        "tanggal": tgl,
        "rt": rt,
        "rw": rw,
        "foto_sampah": imageUrl,
        "jumlahOrganik": 0.0,
        "jumlahAnorganik": 0.0,
        "poin": 0,
        "status": status,
        "creationTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      isLoading.value = false;
      Get.snackbar(
          "Berhasil", "Request terkirim, tunggu konfirmasi dari petugas",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }
}
