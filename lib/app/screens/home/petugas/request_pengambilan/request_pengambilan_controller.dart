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
  TextEditingController jumlahAnorganikC = TextEditingController();
  TextEditingController jumlahOrganikC = TextEditingController();
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

  //? Update Transaksi Sampah //
  Future<void> updateTransaksi(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v) async {
    isLoading.value = true;
    final petugas = await usersDb.doc(auth.currentUser!.email).get();
    try {
      //? Transaksi ditolak atau Jumlah Anorganik 0
      if (v == 0) {
        //* Update Transaksi Sampah pada Collection Kirim User //
        await usersDb.doc(email).collection("kirim").doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
          "keterangan": keterangan,
          "jenisAnorganik": "-",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        //* Update Jumlah Poin Warga //
        await usersDb.doc(email).update({
          "poin": FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 200))
        });
        //* Update Transaksi Sampah pada Collection transaksiSampah //
        await transaksiDb.doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
          "keterangan": keterangan,
          "jenisAnorganik": "-",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      }
      //? Sampah Jenis Plastik
      if (v == 1) {
        //* Update Transaksi Sampah pada Collection Kirim User //
        await usersDb.doc(email).collection("kirim").doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
          "keterangan": keterangan,
          "jenisAnorganik": "Plastik",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        //* Update Jumlah Poin Warga //
        await usersDb.doc(email).update({
          "poin": FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 200))
        });
        //* Update Transaksi Sampah pada Collection transaksiSampah //
        await transaksiDb.doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "jenisAnorganik": "Plastik",
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
          "keterangan": keterangan,
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      }
      //? Sampah Jenis Kertas
      else if (v == 2) {
        //* Update Transaksi Sampah pada Collection Kirim User //
        await usersDb.doc(email).collection("kirim").doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
          "keterangan": keterangan,
          "jenisAnorganik": "Kertas",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        //* Update Jumlah Poin Warga //
        await usersDb.doc(email).update({
          "poin": FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 200))
        });
        //* Update Transaksi Sampah pada Collection transaksiSampah //
        await transaksiDb.doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
          "keterangan": keterangan,
          "jenisAnorganik": "Kertas",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      }
      //? Sampah Jenis Logam
      else if (v == 3) {
        //* Update Transaksi Sampah pada Collection Kirim User //
        await usersDb.doc(email).collection("kirim").doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 300),
          "keterangan": keterangan,
          "jenisAnorganik": "Logam",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        //* Update Jumlah Poin Warga //
        await usersDb.doc(email).update({
          "poin": FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 300))
        });
        //* Update Transaksi Sampah pada Collection transaksiSampah //
        await transaksiDb.doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 300),
          "keterangan": keterangan,
          "jenisAnorganik": "Logam",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      }
      //? Sampah Jenis Besi
      else if (v == 4) {
        //* Update Transaksi Sampah pada Collection Kirim User //
        await usersDb.doc(email).collection("kirim").doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 320),
          "keterangan": keterangan,
          "jenisAnorganik": "Besi",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        //* Update Jumlah Poin Warga //
        await usersDb.doc(email).update({
          "poin": FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 320))
        });
        //* Update Transaksi Sampah pada Collection transaksiSampah //
        await transaksiDb.doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 320),
          "keterangan": keterangan,
          "jenisAnorganik": "Besi",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      }
      //? Sampah Jenis Botol Kaca
      if (v == 5) {
        //* Update Transaksi Sampah pada Collection Kirim User //
        await usersDb.doc(email).collection("kirim").doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 220),
          "keterangan": keterangan,
          "jenisAnorganik": "Botol Kaca",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        //* Update Jumlah Poin Warga //
        await usersDb.doc(email).update({
          "poin": FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 220))
        });
        //* Update Transaksi Sampah pada Collection transaksiSampah //
        await transaksiDb.doc(id).update({
          "petugas": petugas.get("nama_lengkap"),
          "status": status,
          "jumlahOrganik": jumlahOrganik,
          "jumlahAnorganik": jumlahAnorganik,
          "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 220),
          "keterangan": keterangan,
          "jenisAnorganik": "Botol Kaca",
          "tanggalKonfirmasi":
              DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
      }
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
    //? Transaksi Ditolak atau Jumlah Anorganik 0
    if (v == 0) {
      modelUser(UsersModel(
          poin: FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 200)) as int));
      modelUser.refresh();
    }
    //? Jenis Sampah Plastik
    if (v == 1) {
      modelUser(UsersModel(
          poin: FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 200)) as int));
      modelUser.refresh();
    }
    //? Jenis Sampah Kertas
    if (v == 2) {
      modelUser(UsersModel(
          poin: FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 200)) as int));
      modelUser.refresh();
    }
    //? Jenis Sampah Logam
    if (v == 3) {
      modelUser(UsersModel(
          poin: FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 300)) as int));
      modelUser.refresh();
    }
    //? Jenis Sampah Besi
    if (v == 4) {
      modelUser(UsersModel(
          poin: FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 320)) as int));
      modelUser.refresh();
    }
    //? Jenis Sampah Botol Kaca
    if (v == 5) {
      modelUser(UsersModel(
          poin: FieldValue.increment(
              (jumlahOrganik * 150) + (jumlahAnorganik * 220)) as int));
      modelUser.refresh();
    }
  }
}
