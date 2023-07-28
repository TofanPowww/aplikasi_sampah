import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/color.dart';
import '../../../../constant/fontStyle.dart';
import '../../../../constant/style.dart';

class DetailRiwayatView extends StatefulWidget {
  const DetailRiwayatView({super.key});

  @override
  State<DetailRiwayatView> createState() => _DetailRiwayatViewState();
}

class _DetailRiwayatViewState extends State<DetailRiwayatView> {
  @override
  Widget build(BuildContext context) {
    final allData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Detail Permintaan", style: appFontTitlePage),
        centerTitle: true,
        backgroundColor: colorPrimary,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: boxDecorationInput,
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tanggal", style: appFontFormInput),
                      const SizedBox(height: 4),
                      Text(allData['tgl'], style: appFontHeding2),
                    ],
                  )),
              const SizedBox(height: 8),
              allData['status'] == 'Menunggu'
                  ? const SizedBox()
                  : Container(
                      decoration: boxDecorationInput,
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Nama Petugas", style: appFontFormInput),
                          const SizedBox(height: 4),
                          Text(allData['petugas'], style: appFontHeding2),
                        ],
                      )),
              allData['status'] == 'Menunggu'
                  ? const SizedBox()
                  : const SizedBox(height: 8),
              Container(
                  decoration: boxDecorationInput,
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Status", style: appFontFormInput),
                      const SizedBox(height: 4),
                      Text(allData['status'], style: appFontHeding2)
                    ],
                  )),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        decoration: boxDecorationInput,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Organik (Kg)", style: appFontFormInput),
                            const SizedBox(height: 4),
                            allData['jumlahOrganik'] == 0
                                ? const Text("-", style: appFontHeding2)
                                : Text(
                                    allData['jumlahOrganik'].toStringAsFixed(1),
                                    style: appFontHeding2)
                          ],
                        )),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                        decoration: boxDecorationInput,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Anorganik (Kg)",
                                style: appFontFormInput),
                            const SizedBox(height: 4),
                            allData['jumlahAnorganik'] == 0
                                ? const Text("-", style: appFontHeding2)
                                : Text(
                                    allData['jumlahAnorganik']
                                        .toStringAsFixed(1),
                                    style: appFontHeding2)
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              allData['status'] == 'Menunggu'
                  ? const SizedBox()
                  : Container(
                      decoration: boxDecorationInput,
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Jenis Sampah Anorganik",
                              style: appFontFormInput),
                          const SizedBox(height: 4),
                          allData['jenisAnorganik'] == "-"
                              ? const Text("-", style: appFontHeding2)
                              : Text(allData['jenisAnorganik'],
                                  style: appFontHeding2)
                        ],
                      )),
              allData['status'] == 'Menunggu'
                  ? const SizedBox()
                  : const SizedBox(height: 8),
              Container(
                  decoration: boxDecorationInput,
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Poin", style: appFontFormInput),
                      const SizedBox(height: 4),
                      allData['poin'] == 0
                          ? const Text("-", style: appFontHeding2)
                          : Text(allData['poin'].toString(),
                              style: appFontHeding2)
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
                      const Text("Foto", style: appFontFormInput),
                      const SizedBox(height: 8),
                      Center(
                        child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Image(
                              image: NetworkImage(allData['foto_sampah']),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return const Center(
                                    child: CircularProgressIndicator(
                                        color: colorPrimary));
                              },
                            )),
                      )
                    ],
                  )),
              const SizedBox(height: 8),
              allData['status'] == 'Ditolak'
                  ? Container(
                      decoration: boxDecorationInput,
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Keterangan", style: appFontFormInput),
                          const SizedBox(height: 4),
                          Text(allData['keterangan'], style: appFontHeding2)
                        ],
                      ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
