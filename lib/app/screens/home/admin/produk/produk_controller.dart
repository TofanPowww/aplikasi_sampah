// import 'dart:io';
// import 'dart:typed_data';

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/data/produkModel.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ProdukController extends GetxController {
  var isLoading = false.obs;
  //?Form Controller Edit Produk//
  TextEditingController namaProdukC = TextEditingController();
  TextEditingController desProdukC = TextEditingController();
  TextEditingController poinProdukC = TextEditingController();

  //?Form Controller Add Produk//
  TextEditingController namaProdukAdd = TextEditingController();
  TextEditingController desProdukAdd = TextEditingController();
  TextEditingController poinProdukAdd = TextEditingController();

  //?Firebase
  final db = FirebaseFirestore.instance;
  CollectionReference transaksiDb =
      FirebaseFirestore.instance.collection('transaksiSampah');

  //?Route//
  toKelolaP() => Get.offAndToNamed(AppLinks.KELOLA_PRODUK);
  toTambahProduk() => Get.toNamed(AppLinks.TAMBAH_PRODUK);

  //?Function Add Produk//
  Future<void> tambahProduk(
      String namaProduk, String desProduk, int poinProduk) async {
    isLoading.value = true;
    try {
      CollectionReference produkDb = db.collection('produk');
      await produkDb.add({
        "nama": namaProduk,
        "deskripsi": desProduk,
        "poin": poinProduk,
      }).then((DocumentReference doc) {
        produkDb.doc(doc.id).update({"produk_id": doc.id});
      });
      isLoading.value = false;
      Get.snackbar(
        "Berhasil",
        "Produk berhasil ditambahkan",
        backgroundColor: appSuccess,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Gagal", "Request gagal terkirim",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10));
    }
  }

  //?Update Data Produk//
  Future<void> updateProduk(String id) async {
    isLoading.value = true;
    if (namaProdukC.text.isNotEmpty &&
        desProdukC.text.isNotEmpty &&
        poinProdukC.text.isNotEmpty) {
      try {
        await db.collection('produk').doc(id).update({
          'nama': namaProdukC.text,
          'deskripsi': desProdukC.text,
          'poin': int.parse(poinProdukC.text),
        });
        isLoading.value = false;
        Get.snackbar("Berhasil", "Data berhasil diupdate",
            backgroundColor: appSuccess, snackPosition: SnackPosition.TOP);
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Gagal", "Data gagal diupdate",
            backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
      }
    }
  }

  //?Function Delete Produk//
  Future<void> deleteProduk(String id) async {
    try {
      await db.collection('produk').doc(id).delete();
      toKelolaP();
      Get.snackbar("Berhasil", "Produk berhasil dihapus",
          backgroundColor: appSuccess, snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar("Gagal", "Produk gagal dihapus",
          backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
    }
  }

  //?Function Print Produk//
  RxList<ProdukModel> allDataProduk = List<ProdukModel>.empty().obs;
  void downloadProduk() async {
    final pdf = pw.Document();

    //Mengambil Data dari firebase
    var getDataProduk = await db.collection('produk').get();

    //reset all produk -> untuk mengatasi duplikat
    allDataProduk([]);

    //Memasukkan data ke Model
    for (var element in getDataProduk.docs) {
      allDataProduk.add(ProdukModel.fromJson(element.data()));
    }

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          List<pw.TableRow> allProduk =
              List.generate(allDataProduk.length, (index) {
            ProdukModel data = allDataProduk[index];
            return pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("${index + 1}",
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.nama,
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.poin.toString(),
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.deskripsi,
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                ]);
          });
          return [
            pw.Text("Aplikasi Pickup Sampah Digital",
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text("Katalog Produk BumDes",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.normal)),
            pw.SizedBox(height: 32),
            pw.Table(
                border: pw.TableBorder.all(width: 1.5, color: PdfColors.black),
                children: [
                  pw.TableRow(
                      decoration:
                          const pw.BoxDecoration(color: PdfColors.grey300),
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("No",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
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
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Deskripsi",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                      ]),
                  ...allProduk
                ])
          ];
        }));

    //Simpan
    // Uint8List bytes = await pdf.save();

    //Buat File Kosong
    // final dir = await getTemporaryDirectory();
    // final file = File('${dir.path}/mydocument.pdf');
    // await file.writeAsBytes(await pdf.save());

    //Memasukkan data PDF ke File
    // await file.writeAsBytes(bytes);

    //Open PDF
    // await OpenFile.open(file.path);

    //Print PDF
    await Printing.layoutPdf(
        name: 'Katalog_Produk',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
