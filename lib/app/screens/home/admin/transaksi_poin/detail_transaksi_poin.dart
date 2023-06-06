import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'transaksipoin_controller.dart';

class DetailTransaksiPoin extends StatefulWidget {
  const DetailTransaksiPoin({super.key});

  @override
  State<DetailTransaksiPoin> createState() => _DetailTransaksiPoinState();
}

class _DetailTransaksiPoinState extends State<DetailTransaksiPoin> {
  @override
  void initState() {
    super.initState();
  }

  String? newStatus;

  final TransaksiPoinController control = Get.put(TransaksiPoinController());
  @override
  Widget build(BuildContext context) {
    final TransaksiPoinController control = Get.put(TransaksiPoinController());
    final tukar = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Detail Penukaran", style: appFontTitlePage),
        centerTitle: true,
        backgroundColor: colorPrimary,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
        actions: [
          tukar['status'] == 'Proses'
              ? IconButton(
                  tooltip: "Scan QR untuk konfirmasi penukaran poin",
                  onPressed: () {
                    Get.defaultDialog(
                        backgroundColor: colorBackground2,
                        barrierDismissible: false,
                        title: "Konfirmasi",
                        content: const Text(
                            "Scan Kode QR untuk konfirmasi penukaran?",
                            textAlign: TextAlign.center,
                            style: appFontFormInput),
                        titleStyle: appFontFormInputa,
                        titlePadding: const EdgeInsets.only(top: 16, bottom: 8),
                        contentPadding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child:
                                  const Text("Batal", style: appFontFormInput)),
                          ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(colorAccent),
                              ),
                              onPressed: () {
                                FlutterBarcodeScanner.scanBarcode(
                                        "#101014", "Batal", true, ScanMode.QR)
                                    .then((value) {
                                  control.getTransaksiPoinById(value);
                                });
                                Navigator.of(context).pop();
                              },
                              child:
                                  const Text("Lanjut", style: appFontButtonb))
                        ]);
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded))
              : const SizedBox()
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: tukar['status'] == 'Selesai'
                    ? Lottie.asset('assets/lottie/done_2.json',
                        repeat: true,
                        reverse: false,
                        animate: true,
                        frameRate: FrameRate.max,
                        height: 250,
                        width: 250)
                    : tukar['status'] == 'Batal'
                        ? Lottie.asset('assets/lottie/cancel.json',
                            repeat: true,
                            reverse: false,
                            animate: true,
                            frameRate: FrameRate.max,
                            height: 250,
                            width: 250)
                        : const SizedBox()),
            tukar['status'] == 'Proses'
                ? const SizedBox()
                : const SizedBox(height: 16),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Email", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(tukar['email'], style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Nama Produk", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(tukar['nama_produk'], style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Poin Produk", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(tukar['poin_produk'].toString(),
                        style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 8),
            tukar['status'] == 'Selesai'
                ? SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {
                          control.downloadBuktiTransaksiPoin(
                              tukar["id"],
                              tukar["email"],
                              tukar["confirmTime"],
                              tukar["status"],
                              tukar["nama_produk"],
                              tukar["poin_produk"]);
                        },
                        style: btnStylePrimary,
                        child: const Text("Bukti Transaksi",
                            style: appFontButton)),
                  )
                : const SizedBox()
          ],
        ),
      )),
    );
  }
}
