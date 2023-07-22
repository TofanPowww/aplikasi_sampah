// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant/color.dart';
import '../../../../data/models/users_model.dart';
import '../../../../../service/authentication.dart';

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
  // NEED TO TEST : Konfirmasi Transaksi Sampah
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
    String namaPetugas = petugas.get("nama_lengkap");
    //? Transaksi ditolak
    if (status == "Ditolak" && v == 0) {
      print(status);
      ditolak(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Jumlah Anorganik 0
    else if (v == 0 && status == "Diterima") {
      print("Anorganik 0");
      organikSaja(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Sampah Jenis Plastik
    else if (v == 1) {
      print("Plastik");
      plastik(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Sampah Jenis Kertas
    else if (v == 2) {
      print("Kertas");
      plastik(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Sampah Jenis Logam
    else if (v == 3) {
      print("Logam");
      plastik(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Sampah Jenis Besi
    else if (v == 4) {
      print("Besi");
      plastik(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Sampah Jenis Botol Kaca
    else if (v == 5) {
      print("Botol Kaca");
      plastik(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
  }

  void ditolak(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": 0.0,
        "jumlahAnorganik": 0.0,
        "poin": 0,
        "keterangan": keterangan,
        "jenisAnorganik": "-",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": 0.0,
        "jumlahAnorganik": 0.0,
        "poin": 0,
        "keterangan": keterangan,
        "jenisAnorganik": "-",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }

  void organikSaja(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": 0.0,
        "poin": jumlahOrganik * 150,
        "keterangan": keterangan,
        "jenisAnorganik": "-",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb
          .doc(email)
          .update({"poin": FieldValue.increment(jumlahOrganik * 150 as int)});
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": 0.0,
        "poin": jumlahOrganik * 150,
        "keterangan": keterangan,
        "jenisAnorganik": "-",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }

  void plastik(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
        "keterangan": keterangan,
        "jenisAnorganik": "Plastik",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 150) + (jumlahAnorganik * 200) as int)
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "jenisAnorganik": "Plastik",
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }

  void kertas(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 150) + (jumlahAnorganik * 200) as int)
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 200),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }

  void logam(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 300),
        "keterangan": keterangan,
        "jenisAnorganik": "Logam",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 150) + (jumlahAnorganik * 300) as int)
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 300),
        "keterangan": keterangan,
        "jenisAnorganik": "Logam",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }

  void besi(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 320),
        "keterangan": keterangan,
        "jenisAnorganik": "Besi",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 150) + (jumlahAnorganik * 320) as int)
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 320),
        "keterangan": keterangan,
        "jenisAnorganik": "Besi",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }

  void botolKaca(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v,
      String petugas) async {
    try {
      //* Update Transaksi Sampah pada Collection Kirim User //
      await usersDb.doc(email).collection("kirim").doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 220),
        "keterangan": keterangan,
        "jenisAnorganik": "Botol Kaca",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 150) + (jumlahAnorganik * 220) as int)
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": (jumlahOrganik * 150) + (jumlahAnorganik * 220),
        "keterangan": keterangan,
        "jenisAnorganik": "Botol Kaca",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
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
  }
}
