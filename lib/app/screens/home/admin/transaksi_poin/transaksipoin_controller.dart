// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/data/transaksiTukarModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransaksiPoinController extends GetxController {
  //? Firebase //
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference transaksiDb =
      FirebaseFirestore.instance.collection('transaksiTukar');

  //? Stream Data Transaksi Sampah//
  Stream<QuerySnapshot> transaksiTukarStream() {
    return db
        .collection("transaksiTukar")
        .orderBy('creationTime', descending: true)
        .snapshots();
  }

  //?Proses Mengambil Data Transaksi Poin dari Firestore//
  Future getTransaksiPoinById(String id) async {
    CollectionReference tPoinDb = db.collection('transaksiTukar');
    CollectionReference usersDb = db.collection('users');
    try {
      var hasil = await db.collection("transaksiTukar").doc(id).get();
      if (hasil.data() != null) {
        //*Mengupdate Status Transaksi Pada Collection Transaksi Sampah
        await tPoinDb.doc(id).update({
          "status": "Selesai",
          "confirmTime":
              DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
        });

        //*Mengambil Email Warga
        String emailWarga = hasil.get("email");

        //*Mengambil Poin Produk
        int poinP = hasil.get("poin_produk");

        //*Mengupdate Status Transaksi Tukar Pada Warga
        await usersDb.doc(emailWarga).collection("tukar").doc(id).update({
          "status": "Selesai",
          "confirmTime":
              DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
        });

        //*Mengupdate Jumlah Poin Warga
        await usersDb
            .doc(emailWarga)
            .update({"poin": FieldValue.increment(-poinP)});

        Get.back(closeOverlays: true);
        Get.snackbar(
          "Berhasil",
          "Transaksi Penukaran Poin Berhasil",
          backgroundColor: appSuccess,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          "Gagal",
          "Kode Penukaran Tidak Ditemukan",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal Mendapatkan Detail Transaksi",
        backgroundColor: appDanger,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  //?Function Print Bukti Transaksi Poin//
  RxList<TransaksiTukarModel> allDataTransksi =
      List<TransaksiTukarModel>.empty().obs;
  void downloadBuktiTransaksiPoin(String id, String email, String tanggal,
      String status, String namaProduk, int poin) async {
    final pdf = pw.Document();

    //*Function Create PDF
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
                            pw.Text(email,
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

    //*Print PDF
    await Printing.layoutPdf(
        name: 'Bukti_Penukaran',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
