// ignore_for_file: avoid_print
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_petugas_controller.dart';

class AddPetugas extends StatefulWidget {
  const AddPetugas({Key? key}) : super(key: key);
  @override
  State<AddPetugas> createState() => _AddPetugasState();
}

class _AddPetugasState extends State<AddPetugas> {
  final c = Get.put(AddPetugasController());
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool showProgres = false;

  String pEmail = '';
  String pNama = '';
  String pWa = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          title: const Text('Tambah Petugas', style: appFontTitlePage),
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
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 56,
                                        decoration:
                                            boxDecorationInputSmallAccent,
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            top: 8,
                                            bottom: 8,
                                            right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Daftar sebagai",
                                              style: appFontFormInput,
                                            ),
                                            const SizedBox(width: 16),
                                            DropdownButton<String>(
                                              dropdownColor: colorSecondary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              iconSize: 30,
                                              underline: Container(
                                                  height: 0,
                                                  color: Colors.transparent),
                                              icon: const Icon(Icons
                                                  .arrow_drop_down_rounded),
                                              iconEnabledColor: colorPrimary,
                                              style: appFontFormInput,
                                              alignment: Alignment.center,
                                              value: c.currentItemSelected,
                                              items: c.option.map(
                                                  (String dropDownStringItem) {
                                                return DropdownMenuItem<String>(
                                                  value: dropDownStringItem,
                                                  child:
                                                      Text(dropDownStringItem),
                                                );
                                              }).toList(),
                                              onChanged: (newValueSelected) {
                                                setState(() {
                                                  c.currentItemSelected =
                                                      newValueSelected!;
                                                  c.rool = newValueSelected;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      TextFormField(
                                        controller: c.emailpetugasC,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: appFontFormInput,
                                        cursorColor: colorPrimary,
                                        cursorHeight: 25,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            enabled: true,
                                            fillColor: colorSecondary,
                                            label: Text("Email"),
                                            labelStyle: appFontFormInput,
                                            floatingLabelStyle:
                                                appFontFormInput,
                                            focusColor: colorSecondary,
                                            enabledBorder: enableInputBorder,
                                            focusedBorder: focusInputBorder,
                                            errorBorder: errorInputBorder,
                                            focusedErrorBorder:
                                                errorInputBorder),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Email tidak boleh kosong";
                                          }
                                          if (!RegExp(
                                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return ("Masukkan email dengan benar");
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) => pEmail = value,
                                      ),
                                      const SizedBox(height: 24),
                                      TextFormField(
                                        controller: c.namapetugasC,
                                        style: appFontFormInput,
                                        cursorColor: colorPrimary,
                                        cursorHeight: 25,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: colorSecondary,
                                            label: Text("Nama Lengkap"),
                                            labelStyle: appFontLabelForm,
                                            floatingLabelStyle:
                                                appFontFormInput,
                                            focusColor: colorSecondary,
                                            enabledBorder: enableInputBorder,
                                            focusedBorder: focusInputBorder,
                                            errorBorder: errorInputBorder,
                                            focusedErrorBorder:
                                                errorInputBorder),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Nama tidak boleh kosong";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) => pNama = value,
                                      ),
                                      const SizedBox(height: 24),
                                      TextFormField(
                                        controller: c.wapetugasC,
                                        style: appFontFormInput,
                                        cursorColor: colorPrimary,
                                        cursorHeight: 25,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: colorSecondary,
                                            label: Text("No. WhatsApp"),
                                            labelStyle: appFontLabelForm,
                                            floatingLabelStyle:
                                                appFontFormInput,
                                            focusColor: colorSecondary,
                                            enabledBorder: enableInputBorder,
                                            focusedBorder: focusInputBorder,
                                            errorBorder: errorInputBorder,
                                            focusedErrorBorder:
                                                errorInputBorder),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "No. WhatsApp tidak boleh kosong";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) => pEmail = value,
                                      )
                                    ])),
                            const SizedBox(height: 32),
                            SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: Obx(() => ElevatedButton(
                                    onPressed: () {
                                      final bool? isValid =
                                          formKey.currentState?.validate();
                                      AddPetugasController
                                              .instance.isLoading.value
                                          ? null
                                          : isValid == true
                                              ? AddPetugasController.instance
                                                  .tambahPetugas(
                                                  c.rool.trim(),
                                                  c.emailpetugasC.text.trim(),
                                                  c.namapetugasC.text.trim(),
                                                  c.wapetugasC.text.trim(),
                                                )
                                                  .whenComplete(() {
                                                  c.emailpetugasC.clear();
                                                  c.namapetugasC.clear();
                                                  c.wapetugasC.clear();
                                                })
                                              : null;
                                    },
                                    style: btnStylePrimary,
                                    child: AddPetugasController
                                            .instance.isLoading.value
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
                                        : const Text("Daftar",
                                            style: appFontButton))))
                          ]),
                    )))));
  }
}
