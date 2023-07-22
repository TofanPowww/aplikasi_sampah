// ignore_for_file: unrelated_type_equality_checks, avoid_print
import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/service/authentication.dart';
import 'package:aplikasi_sampah/service/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'kirim_controller.dart';

class KirimSampahView extends StatefulWidget {
  const KirimSampahView({super.key});

  @override
  State<KirimSampahView> createState() => _KirimSampahViewState();
}

class _KirimSampahViewState extends State<KirimSampahView> {
  final AuthController authC = Get.put(AuthController());
  final KirimController kirimC = Get.put(KirimController());
  String rt = '01';
  String rw = '01';
  String token = "";

  @override
  void initState() {
    super.initState();
    kirimC.dateinput.text = "";
    kirimC.petugas().then((value) {
      token = value.docs.single['token'];
      print('Token: $token');
    });
  }

  RxBool isLoading = false.obs;

  Widget bottomSheet(BuildContext context) {
    final picker = ImagePicker();
    Future kamera() async {
      try {
        final pick = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          kirimC.foto = File(pick!.path);
        });
      } catch (e) {
        print(e);
      }
    }

    Future gallery() async {
      try {
        final pick = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          kirimC.foto = File(pick!.path);
        });
      } catch (e) {
        print(e);
      }
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.17,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          const Text("Pilih foto", style: appFontHeding2),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_search_rounded, color: colorPrimary),
                    SizedBox(height: 16),
                    Text("Gallery", style: appFontFormInput)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  gallery();
                },
              ),
              const SizedBox(width: 120),
              InkWell(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_rounded, color: colorPrimary),
                    SizedBox(height: 16),
                    Text("Kamera", style: appFontFormInput)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  kamera();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          title: const Text("Kirim Sampah", style: appFontTitlePage),
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
                    Form(
                      key: kirimC.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Nama", style: appFontHeding3a),
                          const SizedBox(height: 8),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: kirimC.streamUser(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  Map<String, dynamic> data =
                                      snapshot.data!.data()!;
                                  kirimC.nama.text = data['nama_lengkap'];
                                }
                                return TextFormField(
                                    controller: kirimC.nama,
                                    autocorrect: false,
                                    readOnly: true,
                                    style: appFontFormInput,
                                    keyboardType: TextInputType.name,
                                    cursorColor: colorPrimary,
                                    cursorHeight: 25,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: colorSecondary,
                                        enabledBorder: enableInputBorder,
                                        focusedBorder: focusInputBorder));
                              }),
                          const SizedBox(height: 24),
                          const Text("Alamat Pengambilan",
                              style: appFontHeding3a),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorSecondary,
                                    border: Border.all(
                                        color: colorPrimary,
                                        width: 1.5,
                                        style: BorderStyle.solid)),
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8, right: 8),
                                child: Row(
                                  children: [
                                    const Text("RT", style: appFontHeding3a),
                                    const SizedBox(width: 24),
                                    DropdownButton(
                                      style: appFontFormInput,
                                      dropdownColor: colorSecondary,
                                      iconEnabledColor: colorAccent,
                                      iconSize: 30,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_rounded),
                                      underline: Container(height: 0),
                                      borderRadius: BorderRadius.circular(10),
                                      value: rt,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          rt = newValue ?? "";
                                        });
                                      },
                                      items: <String>[
                                        '01',
                                        '02',
                                        '03',
                                        '04',
                                        '05'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorSecondary,
                                    border: Border.all(
                                        color: colorPrimary,
                                        width: 1.5,
                                        style: BorderStyle.solid)),
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8, right: 8),
                                child: Row(
                                  children: [
                                    const Text("RW", style: appFontHeding3a),
                                    const SizedBox(width: 24),
                                    DropdownButton(
                                      style: appFontFormInput,
                                      dropdownColor: colorSecondary,
                                      iconEnabledColor: colorAccent,
                                      iconSize: 30,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_rounded),
                                      underline: Container(height: 0),
                                      borderRadius: BorderRadius.circular(10),
                                      value: rw,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          rw = newValue ?? "";
                                        });
                                      },
                                      items: <String>[
                                        '01',
                                        '02',
                                        '03',
                                        '04',
                                        '05'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text("Tanggal Pengambilan",
                              style: appFontHeding3a),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: kirimC.dateinput,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                                        .format(pickedDate);
                                setState(() {
                                  kirimC.dateinput.text =
                                      formattedDate.toString();
                                });
                              } else {
                                debugPrint(
                                    "Tanggal pengambilan belum ditentukan");
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan Tanggal Pengambilan';
                              }
                              return null;
                            },
                            onChanged: (value) => kirimC.dateinput.text = value,
                            style: appFontFormInput,
                            decoration: const InputDecoration(
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                label: Text("Piih tanggal pengambilan"),
                                fillColor: colorSecondary,
                                focusColor: colorSecondary,
                                floatingLabelStyle: appFontFormInput,
                                labelStyle: appFontFormInput,
                                enabledBorder: enableInputBorder,
                                errorBorder: errorInputBorder,
                                focusedErrorBorder: errorInputBorder,
                                focusedBorder: focusInputBorder),
                          ),
                          const SizedBox(height: 24),
                          const Text("Tambahkan foto", style: appFontHeding3a),
                          const SizedBox(height: 8),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorSecondary,
                                  border: Border.all(
                                      width: 1.5,
                                      color: colorPrimary,
                                      style: BorderStyle.solid)),
                              height: 346,
                              width: 500,
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: kirimC.foto == null
                                            ? const Center(
                                                child: Text(
                                                    "Tidak ada foto dipilih",
                                                    style: appFontFormInput))
                                            : Image.file(kirimC.foto as File)),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    colorAccent),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  bottomSheet(context));
                                        },
                                        child: const Text("Pilih foto",
                                            style: appFontButtonb))
                                  ],
                                ),
                              )),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: Obx(() => ElevatedButton(
                                onPressed: () {
                                  final bool? isValid =
                                      kirimC.formKey.currentState?.validate();
                                  kirimC.isLoading.value
                                      ? null
                                      : isValid == true
                                          ? kirimC.foto == null
                                              ? Get.snackbar(
                                                  "Foto Profil Kosong",
                                                  "Masukkan Foto Profil Anda!",
                                                  backgroundColor: appDanger,
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                )
                                              : kirimC
                                                  .addNewKirim(
                                                  kirimC.nama.text.trim(),
                                                  rt.trim(),
                                                  rw.trim(),
                                                  kirimC.dateinput.text.trim(),
                                                )
                                                  .then((value) {
                                                  FirebaseApi().sendPushMessage(
                                                      token,
                                                      "Permintaan Masuk",
                                                      "Permintaan pengambilan sampah masuk");
                                                })
                                          : null;
                                },
                                style: btnStylePrimary,
                                child: kirimC.isLoading.value
                                    ? const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                              color: colorBackground),
                                          SizedBox(width: 16),
                                          Text("Sedang memuat...",
                                              style: appFontButton),
                                        ],
                                      )
                                    : const Text(
                                        "Kirim Request",
                                        style: appFontButton,
                                      ))),
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
