import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/routes/links.dart';

class HomeController extends GetxController {
  toKirimSampah() => Get.toNamed(AppLinks.KIRIM_SAMPAH);
  toRiwayat() => Get.toNamed(AppLinks.RIWAYAT);
  toProfil() => Get.toNamed(AppLinks.PROFIL);
  toLogin() => Get.toNamed(AppLinks.LOGIN);
  toRiwayatPengambilan() => Get.toNamed(AppLinks.RIWAYAT_PENGAMBILAN);
  toRequest() => Get.toNamed(AppLinks.REQUEST_PENGAMBILAN);
  toCetak() => Get.toNamed(AppLinks.CETAK_LAPORAN);
  toKelolaPetugas() => Get.toNamed(AppLinks.KELOLA_PETUGAS);
  toKelolaProduk() => Get.toNamed(AppLinks.KELOLA_PRODUK);
  toProfilAdmin() => Get.toNamed(AppLinks.PROFIL_ADMIN);
  toProfilPetugas() => Get.toNamed(AppLinks.PROFIL_PETUGAS);
  toTransaksiPoin() => Get.toNamed(AppLinks.TRANSAKSI_POIN);
  toTransaksiSampah() => Get.toNamed(AppLinks.TRANSAKSI_SAMPAH);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot<Map<String, dynamic>>> streamRole() {
    String? email = auth.currentUser!.email;

    return firestore.collection("users").doc(email).get();
  }

  late Map<String, dynamic> userData;

  Future userStream() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) => userData);
  }
}
