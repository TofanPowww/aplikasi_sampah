// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../service/notification.dart';
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
  Future<void> updateTransaksi(
      String id,
      String email,
      String tgl,
      double jumlahOrganik,
      double jumlahAnorganik,
      String status,
      String keterangan,
      int v) async {
    // isLoading.value = true;
    final petugas = await usersDb.doc(auth.currentUser!.email).get();
    final warga = await usersDb.doc(email).get();

    String namaPetugas = petugas.get("nama_lengkap");
    String tokenWarga = warga.get('token');
    //? Transaksi ditolak
    if (status == "Ditolak" && v == 16) {
      print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
      await ditolak(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
      FirebaseApi().sendPushMessage(tokenWarga, 'Permintaan Ditolak',
          'Maaf petugas tidak bisa mengambil sampah');
    }
    //? Jumlah Anorganik 0
    if (status == "Diterima") {
      if (v == 0) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        organikSaja(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 1) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        plastikKemasan(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 2) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        plastikKresek(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 3) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        gelasBotol(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 4) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        plastikMinum(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 5) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        arsip(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 6) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        koran(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 7) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        kardus(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 8) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        kertasCampur(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 9) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        seng(id, email, tgl, jumlahOrganik, jumlahAnorganik, status, keterangan,
            v, namaPetugas);
      }
      if (v == 10) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        besi(id, email, tgl, jumlahOrganik, jumlahAnorganik, status, keterangan,
            v, namaPetugas);
      }
      if (v == 11) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        alumini(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 12) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        tembaga(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 13) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        beling(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 14) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        botolKaca(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 15) {
        print("Data: $status, $keterangan, $jumlahOrganik, $jumlahAnorganik");
        campuran(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
    }
  }

  Future<void> ditolak(
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
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
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
        "poin": (jumlahOrganik * 100).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "-",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb
          .doc(email)
          .update({"poin": FieldValue.increment(jumlahOrganik * 100)});
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": 0.0,
        "poin": (jumlahOrganik * 100).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "-",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void plastikKemasan(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 400)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Plastik Kemasan",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 400))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "jenisAnorganik": "Plastik Kemasan",
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 400)).toInt(),
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void plastikKresek(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 500)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Plastik Kresek",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 500))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "jenisAnorganik": "Plastik Kresek",
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 500)).toInt(),
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void gelasBotol(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 4000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Gelas/Botol",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 4000))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "jenisAnorganik": "Gelas/Botol",
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 4000)).toInt(),
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void plastikMinum(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1500)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Plastik Minuman Campur",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 1500))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "jenisAnorganik": "Plastik Minuman Campur",
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1500)).toInt(),
        "keterangan": keterangan,
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void arsip(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1800)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Arsip",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 1800))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1800)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Arsip",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void koran(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Koran",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 1000))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Koran",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void kardus(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1200)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kardus",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 1200))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1200)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kardus",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void kertasCampur(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 450)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Campur",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 450))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 450)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Campur",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void seng(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1800)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Seng",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 1800))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 1800)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Seng",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 2500)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Besi",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 2500))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 2500)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Besi",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void alumini(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 10000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Aluminium",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 10000))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 10000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Aluminium",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void tembaga(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 40000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Tembaga",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 40000))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 40000)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Tembaga",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 500)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Botol Kaca",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 500))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 500)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Botol Kaca",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void beling(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 250)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Beling",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 250))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 250)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Beling",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "bulan": DateFormat("MMMM", "id_ID").format(DateTime.now())
      });
      // isLoading.value = false;
      Get.back();
      Get.snackbar("Berhasil", "Transaksi Selesai",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  void campuran(
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
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 250)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Sampah Campuran",
        "tanggalKonfirmasi":
            DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now()),
        "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      });
      //* Update Jumlah Poin Warga //
      await usersDb.doc(email).update({
        "poin": FieldValue.increment(
            (jumlahOrganik * 100) + (jumlahAnorganik * 250))
      });
      //* Update Transaksi Sampah pada Collection transaksiSampah //
      await transaksiDb.doc(id).update({
        "petugas": petugas,
        "status": status,
        "jumlahOrganik": jumlahOrganik + 0.0,
        "jumlahAnorganik": jumlahAnorganik + 0.0,
        "poin": ((jumlahOrganik * 100) + (jumlahAnorganik * 250)).toInt(),
        "keterangan": keterangan,
        "jenisAnorganik": "Sampah Campuran",
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
      // isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }
}
