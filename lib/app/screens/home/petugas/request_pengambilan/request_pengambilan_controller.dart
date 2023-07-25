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
    if (status == "Ditolak") {
      print(status);
      ditolak(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
          keterangan, v, namaPetugas);
    }
    //? Jumlah Anorganik 0
    if (status == "Diterima") {
      if (v == 0) {
        print("Anorganik 0");
        organikSaja(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 1) {
        print("Plastik Kemasan");
        plastikKemasan(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 2) {
        print("Plastik Kresek ");
        plastikKresek(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 3) {
        print("Gelas/Botol");
        gelasBotol(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 4) {
        print("Plastik Minuman Campur");
        plastikMinum(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 5) {
        print("Arsip");
        arsip(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 6) {
        print("Koran");
        koran(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 7) {
        print("Kardus");
        kardus(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 8) {
        print("Kertas Campur");
        kertasCampur(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 9) {
        print("Seng");
        seng(id, email, tgl, jumlahOrganik, jumlahAnorganik, status, keterangan,
            v, namaPetugas);
      }
      if (v == 10) {
        print("Besi");
        besi(id, email, tgl, jumlahOrganik, jumlahAnorganik, status, keterangan,
            v, namaPetugas);
      }
      if (v == 11) {
        print("Aluminium");
        alumini(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 12) {
        print("Tembaga");
        tembaga(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 13) {
        print("Beling");
        beling(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 14) {
        print("Botol Kaca");
        botolKaca(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
      if (v == 15) {
        print("Campuran");
        campuran(id, email, tgl, jumlahOrganik, jumlahAnorganik, status,
            keterangan, v, namaPetugas);
      }
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
        "poin": jumlahOrganik * 100,
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
        "poin": jumlahOrganik * 100,
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 400),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 400),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 4000),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 4000),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1800),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1800),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Arsip",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1000),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1000),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Koran",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1200),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1200),
        "keterangan": keterangan,
        "jenisAnorganik": "Kardus",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 450),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 450),
        "keterangan": keterangan,
        "jenisAnorganik": "Kertas Campur",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1800),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 1800),
        "keterangan": keterangan,
        "jenisAnorganik": "Seng",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 2500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 2500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 10000),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 10000),
        "keterangan": keterangan,
        "jenisAnorganik": "Aluminium",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 40000),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 40000),
        "keterangan": keterangan,
        "jenisAnorganik": "Tembaga",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 500),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 250),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 250),
        "keterangan": keterangan,
        "jenisAnorganik": "Beling",
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 250),
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
        "poin": (jumlahOrganik * 100) + (jumlahAnorganik * 250),
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
      isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }
}
