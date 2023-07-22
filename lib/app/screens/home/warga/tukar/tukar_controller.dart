// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../../service/workmanager.dart';
import '../../../../constant/color.dart';

class TukarController extends GetxController {
  //? Routing //
  toTukarRiwayat() => Get.toNamed(AppLinks.TUKAR_POIN_HISTORY);
  toDetailProduk() => Get.toNamed(AppLinks.TUKAR_POIN_PRODUK);

  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //? Dropdown Value //
  var statusOption = ['Proses', 'Selesai', 'Batal'];
  var currentStatusSelected = "Proses";
  var status = "Proses";

  //? Stream Data User //
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String? email = auth.currentUser!.email;
    yield* db.collection('users').doc(email).snapshots();
  }

  var hasil = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .get();

  //? Membuat Transaksi Tukar Poin //
  Future<void> transaksiTukar(String namaProduk, int poinProduk) async {
    String? email = auth.currentUser!.email;
    CollectionReference userDB = db.collection("users");
    CollectionReference transaksiTukarDB = db.collection("transaksiTukar");
    final tukarUser = userDB.doc(email).collection("tukar");

    // try {
    //* Menyimpan Data Tukar Poin ke Nested Collection User //
    await tukarUser.add({
      "nama_produk": namaProduk,
      "poin_produk": poinProduk,
      "status": status,
      "tanggal":
          DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(DateTime.now()),
      "creationTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
    }).then((DocumentReference doc) async {
      tukarUser.doc(doc.id).update({"kode": doc.id});

      //* Menyimpan Data Transaksi Tukar Poin ke Collection transaksiTukar //
      await transaksiTukarDB.doc(doc.id).set({
        "id": doc.id,
        "kode": doc.id,
        "email": email,
        "nama_produk": namaProduk,
        "poin_produk": poinProduk,
        "status": status,
        "tanggal":
            DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(DateTime.now()),
        "creationTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      }).then((value) => batasWaktu(email!, doc.id));

      // Get.offAndToNamed(AppLinks.TUKAR_POIN);
      // Get.back();
      // Get.snackbar(
      //     "Penukaran Berhasil", "Silahkan cek di halaman Riwayat Penukaran",
      //     backgroundColor: appSuccess,
      //     snackPosition: SnackPosition.TOP,
      //     margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    });
    // } catch (e) {
    //   Get.snackbar("Gagal Menukar", "Proses penukaran gagal",
    //       backgroundColor: appDanger,
    //       snackPosition: SnackPosition.TOP,
    //       margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    // }
  }

  //? Stream Riwayat Transaksi Poin User(Warga) //
  Stream<QuerySnapshot> riwayatTukarStream() {
    User? users = auth.currentUser;
    return db
        .collection("users")
        .doc(users!.email)
        .collection("tukar")
        .orderBy("creationTime", descending: true)
        .snapshots();
  }

  //? Function Cetak Bukti Transaksi Poin //
  void downloadBuktiTransaksiPoin(String id, String tanggal, String status,
      String namaProduk, int poin) async {
    User? users = auth.currentUser;
    final pdf = pw.Document();

    //* Function Create PDF //
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Aplikasi Pickup Sampah Digital",
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text("Bukti Transaksi Penukaran Poin",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.normal)),
                pw.SizedBox(height: 32),
                pw.Divider(
                    borderStyle: pw.BorderStyle.solid,
                    thickness: 2,
                    height: 1.5),
                pw.SizedBox(height: 2),
                pw.Divider(
                    borderStyle: pw.BorderStyle.solid,
                    thickness: 2,
                    height: 1.5),
                pw.SizedBox(height: 32),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("ID Penukaran :",
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 4),
                            pw.Text(id,
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.normal)),
                            pw.SizedBox(height: 8),
                            pw.Text("Email Warga :",
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 4),
                            pw.Text(users!.email.toString(),
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.normal)),
                            pw.SizedBox(height: 8),
                            pw.Text("Status :",
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 4),
                            pw.Text(status,
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.normal)),
                          ]),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text("Tanggal :",
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 4),
                            pw.Text(tanggal,
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.normal)),
                          ])
                    ]),
                pw.SizedBox(height: 32),
                pw.Table(
                    border:
                        pw.TableBorder.all(width: 1.5, color: PdfColors.black),
                    children: [
                      pw.TableRow(
                          decoration:
                              const pw.BoxDecoration(color: PdfColors.grey300),
                          verticalAlignment:
                              pw.TableCellVerticalAlignment.middle,
                          children: [
                            pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text("Nama Produk",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text("Poin Produk",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                    textAlign: pw.TextAlign.center)),
                          ]),
                      pw.TableRow(
                          verticalAlignment:
                              pw.TableCellVerticalAlignment.middle,
                          children: [
                            pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(namaProduk,
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal),
                                    textAlign: pw.TextAlign.center)),
                            pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(poin.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal),
                                    textAlign: pw.TextAlign.center)),
                          ]),
                    ])
              ]);
        }));

    //* Print PDF //
    await Printing.layoutPdf(
        name: 'Bukti_Penukaran',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  void batasWaktu(String email, String id) {
    try {
      Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
      Workmanager().registerOneOffTask(taskActive, taskActive,
          inputData: <String, dynamic>{'email': email, 'idTransaksi': id},
          initialDelay: const Duration(seconds: 20),
          constraints: Constraints(networkType: NetworkType.connected),
          existingWorkPolicy: ExistingWorkPolicy.append
          ); //FIXME: Pemilihan Jenis Register Task

      Get.back();
      Get.snackbar(
          "Penukaran Berhasil", "Silahkan cek di halaman Riwayat Penukaran",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    } catch (e) {
      Get.snackbar("Gagal Menukar", "Proses penukaran gagal",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  Future<void> updateData(String id) async {
    CollectionReference transaksiTukarDB = db.collection("transaksiTukar");

    await transaksiTukarDB.doc(id).update({
      "status": "Batal",
      "confirmTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
    });
  }
}
