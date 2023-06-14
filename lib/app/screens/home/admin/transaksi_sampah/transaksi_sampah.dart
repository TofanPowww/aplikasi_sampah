import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cetak_transaksi_sampah.dart';
import 'detail_transaksi_sampah.dart';
import 'transaksisampah_controller.dart';

class TransaksiSampahView extends StatefulWidget {
  const TransaksiSampahView({super.key});

  @override
  State<TransaksiSampahView> createState() => _TransaksiSampahViewState();
}

class _TransaksiSampahViewState extends State<TransaksiSampahView> {
  final TransaksiSampahController control =
      Get.put(TransaksiSampahController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text("Transaksi Sampah", style: appFontTitlePage),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CetakTransaksiSampah(),
                    ));
              },
              icon: const Icon(Icons.picture_as_pdf_rounded),
              color: colorBackground)
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: StreamBuilder<QuerySnapshot>(
          stream: control.transaksiSampahStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: colorPrimary));
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                return ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map<String, dynamic> data =
                        doc.data()! as Map<String, dynamic>;
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DetailTransaksiSampah(),
                                  settings: RouteSettings(arguments: data)));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: boxDecorationInput,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Nama", style: appFontFormInput),
                                    const SizedBox(height: 4),
                                    Text(data['nama'], style: appFontHeding3b),
                                    const SizedBox(height: 8),
                                    const Text("Tanggal",
                                        style: appFontFormInput),
                                    const SizedBox(height: 4),
                                    Text(data['tanggal'],
                                        style: appFontHeding3b),
                                    const SizedBox(height: 8),
                                    data['status'] == 'Ditolak'
                                        ? const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Organik",
                                                      style: appFontFormInput),
                                                  SizedBox(height: 4),
                                                  Text("-",
                                                      style: appFontHeding3b),
                                                ],
                                              ),
                                              SizedBox(width: 8),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Anorganik",
                                                      style: appFontFormInput),
                                                  SizedBox(height: 4),
                                                  Text("-",
                                                      style: appFontHeding3b),
                                                ],
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Organik",
                                                      style: appFontFormInput),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                      data['jumlahOrganik']
                                                          .toString(),
                                                      style: appFontHeding3b),
                                                ],
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Anorganik",
                                                      style: appFontFormInput),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                      data['jumlahAnorganik']
                                                          .toString(),
                                                      style: appFontHeding3b),
                                                ],
                                              )
                                            ],
                                          )
                                  ],
                                ),
                                data['status'] == 'Ditolak'
                                    ? Text(data['status'],
                                        style: appFontHeding3c)
                                    : Text(data['status'],
                                        style: appFontHeding3b),
                              ],
                            ),
                          ),
                        ));
                  }).toList(),
                );
              } else {
                return const Center(
                    child: Text('Tidak ada transaksi', style: appFontHeding2));
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      )),
    );
  }
}
