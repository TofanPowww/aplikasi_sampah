import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'produk_controller.dart';

class ProdukView extends StatefulWidget {
  const ProdukView({super.key});

  @override
  State<ProdukView> createState() => _ProdukState();
}

class _ProdukState extends State<ProdukView> {
  final ProdukController produkC = Get.put(ProdukController());
  final Stream<QuerySnapshot> _listProdukS = FirebaseFirestore.instance
      .collection('produk')
      .orderBy('poin', descending: false)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Produk", style: appFontTitlePage),
        centerTitle: true,
        backgroundColor: colorPrimary,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
        actions: [
          IconButton(
              onPressed: () {
                produkC.downloadProduk();
              },
              icon: const Icon(Icons.picture_as_pdf_rounded),
              color: colorBackground),
          IconButton(
            onPressed: () {
              produkC.toTambahProduk();
            },
            icon: const Icon(Icons.add_rounded),
            color: colorBackground,
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Daftar Produk", style: appFontHeding2),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                  stream: _listProdukS,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Container(
                            height: 100,
                            width: Get.width,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: boxDecorationInputActive,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 14, top: 16, left: 16, right: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data["nama"],
                                          style: appFontHeding2a),
                                      const SizedBox(height: 8),
                                      Text("${data['poin']} Poin",
                                          style: appFontHeding1a)
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Get.toNamed(AppLinks.EDIT_PRODUK,
                                            arguments: data);
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary))
                                ],
                              ),
                            ),
                          );
                        }).toList());
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
