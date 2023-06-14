import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTransaksiSampah extends StatefulWidget {
  const DetailTransaksiSampah({super.key});

  @override
  State<DetailTransaksiSampah> createState() => _DetailTransaksiSampahState();
}

class _DetailTransaksiSampahState extends State<DetailTransaksiSampah> {
  @override
  Widget build(BuildContext context) {
    final allData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Detail Transaksi", style: appFontTitlePage),
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
                    const Text("Nama Warga", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(allData['nama'], style: appFontHeding2),
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
                    const Text("Nama Petugas", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(allData['petugas'], style: appFontHeding2),
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
                    const Text("Tanggal", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(allData['tanggal'], style: appFontHeding2),
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
                    const Text("Alamat", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text("RT/RW", style: appFontFormInput),
                        const SizedBox(width: 16),
                        Text("${allData['rt']} / ${allData['rw']}",
                            style: appFontHeding2),
                        const SizedBox(width: 16),
                      ],
                    )
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
                    Text(allData['status'], style: appFontHeding2)
                  ],
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: boxDecorationInput,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Jumlah Organik", style: appFontFormInput),
                          const SizedBox(height: 4),
                          allData['jumlahOrganik'] == 0
                              ? const Text("-", style: appFontHeding2)
                              : Text(allData['jumlahOrganik'].toString(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Jumlah Anorganik",
                              style: appFontFormInput),
                          const SizedBox(height: 4),
                          allData['jumlahAnorganik'] == 0
                              ? const Text("-", style: appFontHeding2)
                              : Text(allData['jumlahAnorganik'].toString(),
                                  style: appFontHeding2)
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
            allData['status'] == 'Diterima'
                ? Container(
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
                    ))
                : Container(
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
                    )),
          ],
        ),
      )),
    );
  }
}
