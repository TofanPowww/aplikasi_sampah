import 'package:aplikasi_sampah/app/data/transaksiSampah.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransaksiSampahController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final tSampahDb = FirebaseFirestore.instance.collection("transaksiSampah");

  Stream<QuerySnapshot> transaksiSampahStream() {
    return db
        .collection("transaksiSampah")
        .where("status", isNotEqualTo: "Menunggu")
        .snapshots();
  }

  void cetakTransaksiSampah(int v1, int v2, int v3) async {
    if (v1 == 1 && v2 == 1 && v3 == 0) {
      final tSemua = tSampahDb.where("status", isNotEqualTo: "Menunggu");
      await tSemua.get().then((value) => printPdf(value, "Semua", "Semua"));
    }
    if (v1 == 2 && v2 == 1 && v3 == 0) {
      final tSemua = tSampahDb.where("status", isEqualTo: "Diterima");
      await tSemua.get().then((value) => printPdf(value, "Diterima", "Semua"));
    }
    if (v1 == 3 && v2 == 1 && v3 == 0) {
      final tSemua = tSampahDb.where("status", isEqualTo: "Ditolak");
      await tSemua.get().then((value) => printPdf(value, "Ditolak", "Semua"));
    }
  }

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
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          List<pw.TableRow> allTransaksi =
              List.generate(allDataTransaksi.length, (index) {
            TransaksiSampahModel data = allDataTransaksi[index];
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
                      child: pw.Text(data.petugas,
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
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text("No",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Nama Warga",
                                style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Nama Petugas",
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
        name: 'Transaksi_Sampah',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
