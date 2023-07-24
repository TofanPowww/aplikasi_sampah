import 'package:aplikasi_sampah/app/data/transaksiSampah.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransaksiSampahController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final tSampahDb = FirebaseFirestore.instance.collection("transaksiSampah");
  final tSampah = FirebaseFirestore.instance
      .collection("transaksiSampah")
      .where("status", whereIn: ['Diterima', 'Ditolak']);

  Stream<QuerySnapshot> transaksiSampahStream() {
    return tSampah.orderBy('confirmTime', descending: true).snapshots();
  }

  String hariIni =
      DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now());

  //? Fungsi Mengambil Data //
  void cetakTransaksiSampah(int v1, int v2, int v3) async {
    if (v1 == 1 && v2 == 1 && v3 == 0) {
      final tSemua = tSampahDb.where("status", isNotEqualTo: "Menunggu");
      await tSemua.get().then((value) => printPdf(value, "Semua", "Semua"));
    }
    if (v1 == 1 && v2 == 2 && v3 == 0) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("tanggalKonfirmasi", isEqualTo: hariIni);
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Hari ini");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 1) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Januari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Januari");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 2) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Februari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Februari");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 3) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Maret");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Maret");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 4) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "April");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "April");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 5) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Mei");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Mei");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 6) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Juni");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Juni");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 7) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Juli");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Juli");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 8) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Agustus");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Agustus");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 9) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "September");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "September");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 10) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Oktober");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Oktober");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 11) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "November");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "November");
        }
      });
    }
    if (v1 == 1 && v2 == 3 && v3 == 12) {
      final tSemua = tSampahDb
          .where("status", isNotEqualTo: "Menunggu")
          .where("bulan", isEqualTo: "Desember");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Semua", "Desember");
        }
      });
    }
    if (v1 == 2 && v2 == 1 && v3 == 0) {
      final tSemua = tSampahDb.where("status", isEqualTo: "Diterima");
      await tSemua.get().then((value) => printPdf(value, "Diterima", "Semua"));
    }
    if (v1 == 2 && v2 == 2 && v3 == 0) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("tanggalKonfirmasi", isEqualTo: hariIni);
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Hari ini");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 1) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Januari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Januari");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 2) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Februari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Februari");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 3) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Maret");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Maret");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 4) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "April");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "April");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 5) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Mei");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Mei");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 6) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Juni");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Juni");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 7) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Juni");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Juni");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 8) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Agustus");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Agustus");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 9) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "September");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "September");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 10) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Oktober");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Oktober");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 11) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "November");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "November");
        }
      });
    }
    if (v1 == 2 && v2 == 3 && v3 == 12) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Diterima")
          .where("bulan", isEqualTo: "Desember");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Diterima", "Desember");
        }
      });
    }
    if (v1 == 3 && v2 == 1 && v3 == 0) {
      final tSemua = tSampahDb.where("status", isEqualTo: "Ditolak");
      await tSemua.get().then((value) => printPdf(value, "Ditolak", "Semua"));
    }
    if (v1 == 3 && v2 == 2 && v3 == 0) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("tanggalKonfirmasi", isEqualTo: hariIni);
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Hari ini");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 1) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Januari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Januari");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 2) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Februari");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Februari");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 3) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Maret");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Maret");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 4) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "April");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "April");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 5) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Mei");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Mei");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 6) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Juni");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Juni");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 7) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Juli");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Juli");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 8) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Agustus");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Agustus");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 9) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "September");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "September");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 10) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Oktober");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Oktober");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 11) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "November");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "November");
        }
      });
    }
    if (v1 == 3 && v2 == 3 && v3 == 12) {
      final tSemua = tSampahDb
          .where("status", isEqualTo: "Ditolak")
          .where("bulan", isEqualTo: "Desember");
      await tSemua.get().then((value) {
        if (value.docs.isEmpty) {
          Fluttertoast.showToast(msg: "Tidak ada transaksi");
        } else {
          printPdf(value, "Ditolak", "Desember");
        }
      });
    }
  }

  //? Fungsi Cetak //
  RxList<TransaksiSampahModel> allDataTransaksi =
      List<TransaksiSampahModel>.empty().obs;
  void printPdf(QuerySnapshot<Map<String, dynamic>> getData, String status,
      String waktu) async {
    allDataTransaksi([]);
    for (var element in getData.docs) {
      allDataTransaksi.add(TransaksiSampahModel.fromJson(element.data()));
    }
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          List<pw.TableRow> allTransaksi =
              List.generate(allDataTransaksi.length, (index) {
            TransaksiSampahModel data = allDataTransaksi[index];
            return pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.Expanded(
                      flex: 1,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.only(
                              top: 4, bottom: 4, right: 8, left: 8),
                          child: pw.Text("${index + 1}",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 4,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(data.nama,
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 3,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(data.petugas,
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(data.tanggalKonfirmasi,
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 3,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.only(
                              top: 4, bottom: 4, right: 8, left: 8),
                          child: pw.Text(data.status,
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 3,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text((data.jumlahOrganik + 0.0).toString(),
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 3,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                              (data.jumlahAnorganik + 0.0).toString(),
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 3,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(data.jenisAnorganik,
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.only(
                              top: 4, bottom: 4, right: 8, left: 8),
                          child: pw.Text(data.poin.toString(),
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(data.keterangan,
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.normal),
                              textAlign: pw.TextAlign.center))),
                ]);
          });
          return [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Aplikasi Pickup Sampah Digital",
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Tanggal: $hariIni",
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold))
                ]),
            pw.SizedBox(height: 8),
            pw.Text("Daftar Transaksi Sampah",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.normal)),
            pw.SizedBox(height: 16),
            pw.Text("Jenis Transaksi: $status",
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.normal)),
            pw.SizedBox(height: 4),
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
                            padding: const pw.EdgeInsets.only(
                                top: 4, bottom: 4, right: 8, left: 8),
                            child: pw.Text("No",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Nama Warga",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Nama Petugas",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Tanggal Konfirmasi",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.only(
                                top: 4, bottom: 4, right: 8, left: 8),
                            child: pw.Text("Status",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Jumlah Organik",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Jumlah Anorganik",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Jenis Anorganik",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.only(
                                top: 4, bottom: 4, right: 8, left: 8),
                            child: pw.Text("Poin",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("Keterangan",
                                style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                      ]),
                  ...allTransaksi
                ])
          ];
        }));
    //*Print PDF
    await Printing.layoutPdf(
        name: status == "Semua" && waktu == "Semua"
            ? 'Transaksi_Sampah_Semua_Status'
            : status == "Diterima" && waktu == "Semua"
                ? 'Transaksi_Sampah_Diterima'
                : status == "Ditolak" && waktu == "Semua"
                    ? 'Transaksi_Sampah_Ditolak'
                    : status == "Semua" && waktu == "Hari ini"
                        ? 'Transaksi_Sampah_Hari_Ini'
                        : status == "Diterima" && waktu == "Hari ini"
                            ? 'Transaksi_Sampah_Diterima_Hari_Ini'
                            : status == "Ditolak" && waktu == "Hari ini"
                                ? 'Transaksi_Sampah_Ditolak_Hari_Ini'
                                : status == "Semua" &&
                                        (waktu != "Semua" ||
                                            waktu != "Hari ini")
                                    ? 'Transaksi_Sampah_Bulan_$waktu'
                                    : status == "Diterima" &&
                                            (waktu != "Semua" ||
                                                waktu != "Hari ini")
                                        ? 'Transaksi_Sampah_Diterima_Bulan_$waktu'
                                        : 'Transaksi_Sampah_Ditolak_Bulan_$waktu',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
