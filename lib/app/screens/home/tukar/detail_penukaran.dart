import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constant/color.dart';
import '../../../constant/fontStyle.dart';
import 'tukar_controller.dart';

class DetailPenukaranView extends StatefulWidget {
  const DetailPenukaranView({super.key});

  @override
  State<DetailPenukaranView> createState() => _DetailPenukaranViewState();
}

class _DetailPenukaranViewState extends State<DetailPenukaranView> {
  final TukarController control = Get.put(TukarController());
  @override
  Widget build(BuildContext context) {
    final tukar =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
          title: const Text("Detail Penukaran", style: appFontTitlePage),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: colorBackground)),
          backgroundColor: colorPrimary),
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tukar['status'] == 'Proses'
                      ? Container(
                          decoration: boxDecorationInputActive,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              QrImageView(
                                data: tukar['kode'],
                                size: 200,
                                version: 5,
                                dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.circle,
                                    color: colorPrimary),
                                eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.circle,
                                    color: colorPrimary),
                              ),
                              const SizedBox(height: 8),
                              const Text("Kode Penukaran",
                                  style: appFontFormInput),
                              const SizedBox(height: 4),
                              Text(tukar['kode'], style: appFontHeding2),
                            ],
                          ))
                      : const SizedBox(),
                  tukar['status'] == 'Proses'
                      ? const SizedBox(height: 8)
                      : const SizedBox(),
                  tukar['status'] == 'Proses'
                      ? Container(
                          decoration: boxDecorationInputActive,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Batas Waktu", style: appFontFormInput),
                              SizedBox(height: 4),
                              Text("23 Mei 2023 (2 Hari)",
                                  style: appFontHeding2),
                            ],
                          ))
                      : const SizedBox(),
                  tukar['status'] == 'Proses'
                      ? const SizedBox(height: 8)
                      : const SizedBox(),
                  Center(
                      child: tukar['status'] == 'Selesai'
                          ? Lottie.asset('assets/lottie/done_2.json',
                              repeat: true,
                              animate: true,
                              frameRate: FrameRate.max,
                              height: 250,
                              width: 250)
                          : tukar['status'] == 'Batal'
                              ? Lottie.asset('assets/lottie/cancel.json',
                                  repeat: true,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Poin Produk", style: appFontFormInput),
                          const SizedBox(height: 4),
                          Text(tukar['poin_produk'].toString(),
                              style: appFontHeding2),
                        ],
                      )),
                  const SizedBox(height: 8),
                  Container(
                      decoration: boxDecorationInput,
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Status", style: appFontFormInput),
                          const SizedBox(height: 4),
                          Text(tukar['status'], style: appFontHeding2),
                        ],
                      )),
                  const SizedBox(height: 16),
                  tukar['status'] == 'Proses'
                      ? Container(
                          decoration: boxDecorationInputActive,
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Peringatan",
                                style: appFontHeding3b,
                              ),
                              SizedBox(height: 4),
                              Text(
                                  "Segera tunjukkan kode penukaran ke Admin Desa, sebelum batas waktu yang telah ditentukan",
                                  style: appFontFormInput),
                            ],
                          ))
                      : const SizedBox(),
                  tukar['status'] == 'Selesai'
                      ? SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                              onPressed: () {
                                control.downloadBuktiTransaksiPoin(
                                    tukar["kode"],
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
              ))),
    );
  }
}
