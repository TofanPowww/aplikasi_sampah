import 'package:aplikasi_sampah/app/data/models/users_kirim_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant/color.dart';
import '../../../../data/models/users_model.dart';
import '../../../auth/auth_controller.dart';

class RequestPengambilanController extends GetxController {
  //? TextField Controller //
  TextEditingController jumlahC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  var isLoading = false.obs;

  //? Firebase //
  final AuthController authC = Get.put(AuthController());
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  CollectionReference usersDb = FirebaseFirestore.instance.collection('users');
  CollectionReference transaksiDb =
      FirebaseFirestore.instance.collection('transaksiSampah');

  //? Model //
  var modelUser = UsersModel().obs;
  var modelUserKirim = UsersKirimModel().obs;

  //? Update Transaksi Sampah //
  Future<void> updateTransaksi(String id, String email, String tgl, int jumlah,
      String status, String keterangan) async {
    isLoading.value = true;
    final petugas = await usersDb.doc(auth.currentUser!.email).get();
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas.get("nama_lengkap"),
        "status": status,
        "jumlah": jumlah,
        "poin": jumlah * 200,
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM YYYY HH:mm:ss", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });

      //* Update Jumlah Poin Warga //
      await usersDb
          .doc(email)
          .update({"poin": FieldValue.increment(jumlah * 200)});

      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas.get("nama_lengkap"),
        "status": status,
        "jumlah": jumlah,
        "poin": jumlah * 200,
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM YYYY HH:mm:ss", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
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
    //* Update Users Model //
    modelUser(UsersModel(poin: FieldValue.increment(jumlah * 200) as int));
    modelUser.refresh();

    //* Update Users Kirim Model //
    modelUserKirim(UsersKirimModel(
        status: status,
        jumlah: jumlah,
        poin: jumlah * 200,
        petugas: petugas.get("nama_lengkap"),
        keterangan: keterangan,
        tanggalKonfirmasi:
            DateFormat("EEEE, dd MMMM YYYY HH:mm:ss", "id_ID").format(DateTime.now()),
        confirmTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())));
    modelUserKirim.refresh();
  }
}
