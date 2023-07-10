// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/data/petugasModel.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AddPetugasController extends GetxController {
  static AddPetugasController instance = Get.find();

  var isLoading = false.obs;

  //? Firebase //
  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference usersDb = FirebaseFirestore.instance.collection('users');

  //? Form Controller //
  TextEditingController emailpetugasC = TextEditingController();
  TextEditingController namapetugasC = TextEditingController();
  TextEditingController wapetugasC = TextEditingController();

  //? Dropdown Button //
  var option = ['Petugas'];
  var currentItemSelected = "Petugas";
  var rool = "Petugas";

  //Route//
  toKelolaPetugas() => Get.offAndToNamed(AppLinks.KELOLA_PETUGAS);

  //? Function Add Petugas //
  Future<void> tambahPetugas(
      String rool, String email, String nama, String wa) async {
    String emailAdmin = auth.currentUser!.email!;
    final dbAdmin = await usersDb.doc(auth.currentUser!.email).get();
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: "petugas");

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(email).set({
          'rool': rool,
          'email': emailpetugasC.text,
          'nama_lengkap': namapetugasC.text,
          'no_wa': wapetugasC.text,
          'password': "petugas",
          'uid': uid,
        });

        await auth.signOut();
        print("${dbAdmin.get("password")}");

        await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: dbAdmin.get("password"));
      }
      isLoading.value = false;
      Get.snackbar(
        "Berhasil mendaftar",
        "akun berhasil didaftarkan",
        backgroundColor: appSuccess,
        snackPosition: SnackPosition.TOP,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        isLoading.value = false;
        Get.snackbar("Gagal Mendaftar", "Email telah digunakan",
            backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Gagal Mendaftar",
          "terjadi Error",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  //? Function Delete Petugas //
  Future<void> deletePetugas(String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).delete();
      toKelolaPetugas();
      Get.snackbar("Berhasil", "Petugas berhasil dihapus",
          backgroundColor: appSuccess, snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar("Gagal", "Petugas gagal dihapus",
          backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
    }
  }

  //? Function Print PDF //
  RxList<PetugasModel> allDataPetugas = List<PetugasModel>.empty().obs;
  void downloadPetugas() async {
    final pdf = pw.Document();

    //* Mengambil Data dari firebase
    var getDataPetugas =
        await db.collection('users').where('rool', isEqualTo: 'Petugas').get();

    //* reset all produk -> untuk mengatasi duplikat
    allDataPetugas([]);

    //* Memasukkan data ke Model
    for (var element in getDataPetugas.docs) {
      allDataPetugas.add(PetugasModel.fromJson(element.data()));
    }

    //* Function Create PDF
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        List<pw.TableRow> allPetugas =
            List.generate(allDataPetugas.length, (index) {
          PetugasModel data = allDataPetugas[index];
          return pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("${index + 1}",
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
                    child: pw.Text(data.namaLengkap,
                        style: pw.TextStyle(
                            fontSize: 11, fontWeight: pw.FontWeight.normal),
                        textAlign: pw.TextAlign.center)),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(data.noWa,
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
          pw.Text("Daftar Petugas Sampah Aktif",
              style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.normal)),
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
                                  fontSize: 12, fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("Email",
                              style: pw.TextStyle(
                                  fontSize: 12, fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("Nama Lengkap",
                              style: pw.TextStyle(
                                  fontSize: 12, fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.center)),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text("No. WhatsApp",
                              style: pw.TextStyle(
                                  fontSize: 12, fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.center)),
                    ]),
                ...allPetugas
              ])
        ];
      },
    ));

    //* Print PDF
    await Printing.layoutPdf(
        name: 'Daftar_Petugas',
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
