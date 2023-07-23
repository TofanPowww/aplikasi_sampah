import 'package:aplikasi_sampah/service/workmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:workmanager/workmanager.dart';

class ProfilController extends GetxController {
  //? Routing //
  toProfilSaya() => Get.toNamed(AppLinks.PROFIL_SAYA);
  toProfilAdmin() => Get.toNamed(AppLinks.PROFIL_ADMIN);
  toProfilPetugas() => Get.toNamed(AppLinks.PROFIL_PETUGAS);
  toResetPassword() => Get.toNamed(AppLinks.PROFIL_RESET);

  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //? Stream Data Role User //
  Stream<DocumentSnapshot<Map<String, dynamic>>> roleUser() async* {
    String? email = auth.currentUser!.email;
    yield* firestore.collection("users").doc(email).snapshots();
  }

  Future<void> test1() async {
    String? email = auth.currentUser!.email;
    CollectionReference userDB = firestore.collection("users");
    await userDB
        .doc(email)
        .update({'rt': "02"}).then((value) => nextStep(email!, "this_id"));
  }

  void nextStep(String email, String id) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager().registerOneOffTask(testTask, testTask,
        tag: "test",
        constraints: Constraints(networkType: NetworkType.connected),
        inputData: <String, dynamic>{'email': email, 'idTest': id},
        initialDelay: const Duration(minutes: 3));
  }

  Future<void> coba(String email) async {
    CollectionReference userDB = db.collection("users");
    await userDB.doc(email).update({"rt": "04"});
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelByTag("test");
  }
}
