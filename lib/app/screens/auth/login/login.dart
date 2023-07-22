// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/color.dart';
import '../../../constant/style.dart';
import '../../../../service/authentication.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController loginC = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final loginController = Get.put(LoginController());

  bool isLoading = true;
  bool _isHidePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = '';
    String userPass = '';
    return Scaffold(
        backgroundColor: colorBackground,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text("Login", style: appFontTitle),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                          controller:
                                              loginController.emailloginC,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: appFontLabelForm,
                                          cursorColor: colorPrimary,
                                          cursorHeight: 25,
                                          decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: colorSecondary,
                                              label: Text("Email"),
                                              labelStyle: appFontLabelForm,
                                              floatingLabelStyle:
                                                  appFontLabelForm,
                                              focusColor: colorSecondary,
                                              enabledBorder: enableInputBorder,
                                              focusedBorder: focusInputBorder,
                                              errorBorder: errorInputBorder,
                                              focusedErrorBorder:
                                                  errorInputBorder),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.trim().isEmpty) {
                                              return "Email tidak boleh kosong";
                                            }
                                            if (!RegExp(
                                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                .hasMatch(value)) {
                                              return ("Tolong masukkan email yang benar");
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChanged: (value) =>
                                              userEmail = value),
                                      const SizedBox(height: 24),
                                      TextFormField(
                                        controller:
                                            loginController.passwordloginC,
                                        obscureText: _isHidePassword,
                                        keyboardType: TextInputType.text,
                                        style: appFontLabelForm,
                                        cursorColor: colorPrimary,
                                        cursorHeight: 25,
                                        decoration: InputDecoration(
                                            filled: true,
                                            enabled: true,
                                            fillColor: colorSecondary,
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _togglePasswordVisibility();
                                              },
                                              child: Icon(
                                                _isHidePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: colorPrimary,
                                              ),
                                            ),
                                            label: const Text("Password"),
                                            labelStyle: appFontLabelForm,
                                            floatingLabelStyle:
                                                appFontLabelForm,
                                            focusColor: colorSecondary,
                                            enabledBorder: enableInputBorder,
                                            focusedBorder: focusInputBorder,
                                            errorBorder: errorInputBorder,
                                            focusedErrorBorder:
                                                errorInputBorder),
                                        validator: (value) {
                                          RegExp regex = RegExp(r'^.{6,}$');
                                          if (value!.isEmpty) {
                                            return "Password tidak boleh kosong";
                                          }
                                          if (!regex.hasMatch(value)) {
                                            return ("Tolong masukkan password yang benar min. 6 karakter");
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) => userPass = value,
                                      ),
                                      const SizedBox(height: 32),
                                      SizedBox(
                                          width: double.infinity,
                                          height: 56,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                final bool? isValid = formKey
                                                    .currentState
                                                    ?.validate();
                                                if (isValid == true) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                          color: colorAccent,
                                                        ));
                                                      });
                                                  await AuthController.instance
                                                      .login(
                                                          loginController
                                                              .emailloginC.text
                                                              .trim(),
                                                          loginController
                                                              .passwordloginC
                                                              .text
                                                              .trim());
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              style: btnStylePrimary,
                                              child: const Text("Masuk",
                                                  style: appFontButton)))
                                    ]),
                              )),
                          const SizedBox(height: 16),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: const Text("Lupa Password?",
                                  style: appFontButtonText),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Belum punya akun? ",
                                  style: appFontNormal),
                              InkWell(
                                onTap: () => loginC.toSignup(),
                                child: const Text("Daftar",
                                    style: appFontButtonText),
                              )
                            ],
                          )
                        ])))));
  }
}
