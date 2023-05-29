// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

// import '../app/data/userModel.dart';


// class UserProvider with ChangeNotifier {
//   void addUserData({
//     User? currentUser,
//     String? email,
//     String? nama_lengkap,
//     String? nik,
//     String? kk,
//     String? rool,
//     String? wa,
//     String? password,

//   }) 
//   async {
//     await FirebaseFirestore.instance
//         .collection("usersData")
//         .doc(currentUser!.email)
//         .set(
//       {
//         "email": currentUser.email,
//         "nama_lengkap": nama_lengkap,
//         "nik": nik,
//         "kk": kk,
//         "rool": rool,
//         "wa": wa,
//         "wa": wa,
//       },
//     );
//   }

//   UserModel currentData;

//   void getUserData() async {
//     UserModel userModel;
//     var value = await FirebaseFirestore.instance
//         .collection("usersData")
//         .doc(FirebaseAuth.instance.currentUser!.email)
//         .get();
//     if (value.exists) {
//       userModel = UserModel(
//         email: value.get("email"),
//         nama_lengkap: value.get("nama_lengkap"),
//         nik: value.get("nik"),
//         kk: value.get("kk"),
//         rool: value.get("rool"),
//         wa: value.get("wa"),
//         password: value.get("password"),
//       );
//       currentData = userModel;
//       notifyListeners();
//     }
//   }

//   UserModel get currentUserData {
//     return currentData;
//   }
// }