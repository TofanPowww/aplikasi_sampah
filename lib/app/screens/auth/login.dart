// ignore_for_file: avoid_print, unused_local_variable
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/color.dart';
import '../../constant/style.dart';
import 'auth_controller.dart';
import 'login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController loginC = Get.put(AuthController());
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final loginController = Get.put(LoginController());
  bool _isHidePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   requestPermission();
  //   getToken();
  // }

  @override
  Widget build(BuildContext context) {
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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                        controller: loginController.emailloginC,
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
                                            focusedBorder: focusInputBorder),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Email tidak boleh kosong";
                                          }
                                          if (!RegExp(
                                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return ("Tolong masukkan email yang benar");
                                          } else {
                                            return null;
                                          }
                                        }),
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
                                        floatingLabelStyle: appFontLabelForm,
                                        focusColor: colorSecondary,
                                        enabledBorder: enableInputBorder,
                                        focusedBorder: focusInputBorder,
                                      ),
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
                                    ),
                                    const SizedBox(height: 32),
                                    SizedBox(
                                        width: double.infinity,
                                        height: 56,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              AuthController.instance.login(
                                                  loginController
                                                      .emailloginC.text
                                                      .trim(),
                                                  loginController
                                                      .passwordloginC.text
                                                      .trim());
                                            },
                                            style: btnStylePrimary,
                                            child: const Text(
                                              "Masuk",
                                              style: appFontButton,
                                            )))
                                  ])),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Belum punya akun? ",
                                  style: appFontNormal),
                              InkWell(
                                onTap: () => loginC.toSignup(),
                                child: const Text(
                                  "Daftar",
                                  style: appFontButtonText,
                                ),
                              )
                            ],
                          )
                        ])))));
  }

  // //Request Permission//
  // FirebaseMessaging message = FirebaseMessaging.instance;
  // String? mToken = "";
  // void requestPermission() async {
  //   NotificationSettings settings = await message.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User decline or has not accepted permissions');
  //   }
  // }

  // //Get Users Token//
  // void getToken() async {
  //   await message.getToken().then((token) {
  //     setState(() {
  //       mToken = token;
  //       print("My Token is $mToken");
  //     });
  //     saveToken(token!);
  //   });
  // }

  // void saveToken(String token) async {
  //   await db.collection("users").doc(auth.currentUser!.email).update({
  //     "token": token,
  //   });
  // }
}
