// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/data/transaksiTukarModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final poinDb = FirebaseFirestore.instance.collection("transaksiTukar");

  String hariIni =
      DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now());

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
          "tanggalKonfirmasi":
              DateFormat('EEEE, dd MMMM yyyy', "id_ID")
                  .format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          "bulan": DateFormat('MMMM', "id_ID")
                  .format(DateTime.now())
        });

        //*Mengambil Email Warga
        String emailWarga = hasil.get("email");

        //*Mengambil Poin Produk
        int poinP = hasil.get("poin_produk");

        //*Mengupdate Status Transaksi Tukar Pada Warga
        await usersDb.doc(emailWarga).collection("tukar").doc(id).update({
          "status": "Selesai",
          "tanggalKonfirmasi":
              DateFormat('EEEE, dd MMMM yyyy', "id_ID")
                  .format(DateTime.now()),
          "confirmTime":
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
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
      }
      if (hasil.data() == null) {
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

  //? Funngsi Mengambil Data //
  void cetakTransaksiPoin(int v1, int v2) async {
    if (v1 == 1 && v2 == 0) {
      final tSemua = poinDb.where("status", isEqualTo: "Selesai");
      await tSemua.get().then((value) => printPdf(value, "Semua"));
    }
    if (v1 == 2 && v2 == 0) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("tanggalKonfirmasi", isEqualTo: hariIni);
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Hari ini");
        }
      });
    }
    if (v1 == 3 && v2 == 1) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Januari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Januari");
        }
      });
    }
    if (v1 == 3 && v2 == 2) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Februari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Februari");
        }
      });
    }
    if (v1 == 3 && v2 == 3) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Maret");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Maret");
        }
      });
    }
    if (v1 == 3 && v2 == 4) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "April");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "April");
        }
      });
    }
    if (v1 == 3 && v2 == 5) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Mei");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Mei");
        }
      });
    }
    if (v1 == 3 && v2 == 6) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Juni");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Juni");
        }
      });
    }
    if (v1 == 3 && v2 == 7) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Juli");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Juli");
        }
      });
    }
    if (v1 == 3 && v2 == 8) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Agustus");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Agustus");
        }
      });
    }
    if (v1 == 3 && v2 == 9) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "September");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "September");
        }
      });
    }
    if (v1 == 3 && v2 == 10) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Oktober");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Oktober");
        }
      });
    }
    if (v1 == 3 && v2 == 11) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "November");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "November");
        }
      });
    }
    if (v1 == 3 && v2 == 12) {
      final tSemua = poinDb
          .where("status", isEqualTo: "Selesai")
          .where("bulan", isEqualTo: "Desember");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Desember");
        }
      });
    }
  }

  //? Fungsi Cetak //
  RxList<TransaksiTukarModel> allDataTransaksi =
      List<TransaksiTukarModel>.empty().obs;
  void printPdf(
      QuerySnapshot<Map<String, dynamic>> getData, String waktu) async {
    allDataTransaksi([]);
    for (var element in getData.docs) {
      allDataTransaksi.add(TransaksiTukarModel.fromJson(element.data()));
    }
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          List<pw.TableRow> allTransaksi =
              List.generate(allDataTransaksi.length, (index) {
            TransaksiTukarModel data = allDataTransaksi[index];
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
                      child: pw.Text(data.kode,
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.email,
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.namaProduk,
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.poinProduk.toString(),
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.tanggalKonfirmasi,
                          style: pw.TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.normal),
                          textAlign: pw.TextAlign.center)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(data.status,
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
            pw.Text("Daftar Transaksi Poin",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.normal)),
            pw.SizedBox(height: 16),
            pw.Text("Waktu Transaksi: $waktu",
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.normal)),
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
                            child: pw.Text("Kode",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Email Warga",
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
                            child: pw.Text("Tanggal Konfirmasi",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Status",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                      ]),
                  ...allTransaksi
                ])
          ];
        }));
    //*Print PDF
    await Printing.layoutPdf(
        name: 'Transaksi_Poin',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
