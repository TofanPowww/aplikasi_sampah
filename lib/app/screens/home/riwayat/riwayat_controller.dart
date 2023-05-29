import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  //? Firebase //
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  //? Stream Data Kirim Sampah //
  Stream<QuerySnapshot> riwayatStream() async* {
    User? users = auth.currentUser;
    yield* db
        .collection("users")
        .doc(users!.email)
        .collection("kirim")
        .orderBy('tgl', descending: true)
        .snapshots();
  }
}
