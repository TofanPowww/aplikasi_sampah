import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/home/admin/transaksi_poin/cetak_transaksi_poin.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'transaksipoin_controller.dart';

class TransaksiPoinView extends StatefulWidget {
  const TransaksiPoinView({super.key});

  @override
  State<TransaksiPoinView> createState() => _TransaksiPoinViewState();
}

class _TransaksiPoinViewState extends State<TransaksiPoinView> {
  final TransaksiPoinController control = Get.put(TransaksiPoinController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text("Transaksi Penukaran", style: appFontTitlePage),
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
                      builder: (context) => const CetakTransaksiPoin(),
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
          stream: control.transaksiTukarStream(),
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
                          Get.toNamed(AppLinks.DETAIL_TRANSAKSI_POIN,
                              arguments: data);
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: data['status'] == 'Proses'
                                ? boxDecorationInputActive
                                : boxDecorationInput,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Email",
                                        style: appFontFormInput),
                                    const SizedBox(height: 4),
                                    Text(data['email'], style: appFontHeding3b),
                                    const SizedBox(height: 8),
                                    const Text("Nama Produk",
                                        style: appFontFormInput),
                                    const SizedBox(height: 4),
                                    Text(data['nama_produk'],
                                        style: appFontHeding3b),
                                    const SizedBox(height: 8),
                                    const Text("Poin Produk",
                                        style: appFontFormInput),
                                    const SizedBox(height: 4),
                                    Text(data['poin_produk'].toString(),
                                        style: appFontHeding3b),
                                  ],
                                ),
                                data['status'] == 'Batal'
                                    ? Text(data['status'],
                                        style: appFontHeding3c)
                                    : Text(data['status'],
                                        style: appFontHeding3b)
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
