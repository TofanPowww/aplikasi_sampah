// ignore_for_file: avoid_print

import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/users_kirim_model.dart';

class KirimController extends GetxController {
  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //? TextField Controller //
  final formKey = GlobalKey<FormState>();
  final AuthController authC = Get.put(AuthController());
  TextEditingController nama = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  //? Model //
  var kirim = UsersKirimModel().obs;

  void onCLose() {
    dateinput.dispose();
    super.onClose();
  }

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

  //? Menyimpan Transaksi Kirim Sampah //
  Future<void> addNewKirim(String nama, String rt, String rw, String tgl) async {
    User? users = auth.currentUser;
    if (dateinput.text.isNotEmpty && foto != null) {
      try {
        CollectionReference usersDB = db.collection("users");
        CollectionReference transaksiDB = db.collection("transaksiSampah");

        final kirimU = usersDB.doc(auth.currentUser!.email).collection("kirim");
        final docUser = await usersDB.doc(users!.email).get();

        //* Menyimpan Foto Sampah ke Firebase Storage //
        final ref = FirebaseStorage.instance
            .ref()
            .child('foto_data_sampah')
            .child('${docUser}jpg');
        await ref.putFile(foto!);
        imageUrl = await ref.getDownloadURL();

        //* Menambah Nested Collection Kirim pada Collection User//
        final dataKirim = await kirimU.add({
          "tgl": tgl,
          "foto_sampah": imageUrl,
          "jumlah": 0,
          "poin": 0,
          "status": status,
          "creationTime":
              DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
        });

        //* Menambah Transaksi Sampah //
        await transaksiDB.doc(dataKirim.id).set({
          "id": dataKirim.id,
          "email": users.email,
          "nama": nama,
          "tanggal": tgl,
          "rt": rt,
          "rw": rw,
          "foto_sampah": imageUrl,
          "jumlah": 0,
          "poin": 0,
          "status": status,
          "creationTime":
              DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
        });

        //* Update Users Kirim Model //
        kirim(UsersKirimModel(
            tanggal: tgl,
            fotoSampah: imageUrl,
            jumlah: 0,
            poin: 0,
            status: status,
            creationTime:
                DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())));

        Get.snackbar(
            "Berhasil", "Request terkirim, tunggu konfirmasi dari petugas",
            backgroundColor: appSuccess,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));

        kirim.refresh();
      } catch (e) {
        Get.snackbar("Gagal", "Request gagal terkirim",
            backgroundColor: appDanger,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
      }
    } else {
      Get.snackbar("Gagal", "Masukkan semua data",
          backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
    }
  }
}
