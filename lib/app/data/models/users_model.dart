// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel(
      {this.uid,
      this.email,
      this.namaLengkap,
      this.rt,
      this.rw,
      this.wa,
      this.rool,
      this.poin,
      this.password,
      this.fotoProfil,
      this.token
      // this.kirim,
      // this.tukar,
      });

  String? email;
  String? uid;
  String? namaLengkap;
  String? rt;
  String? rw;
  String? wa;
  String? rool;
  int? poin;
  String? password;
  String? fotoProfil;
  String? token;
  // List<Kirim>? kirim;
  // List<Tukar>? tukar;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        uid: json["uid"],
        email: json["email"],
        namaLengkap: json["nama_lengkap"],
        rt: json["rt"],
        rw: json["rw"],
        wa: json["wa"],
        rool: json["rool"],
        poin: json["poin"],
        password: json["password"],
        fotoProfil: json["foto_profil"],
        token: json["token"],
        // kirim: List<Kirim>.from(json["kirim"].map((x) => Kirim.fromJson(x))),
        // tukar: List<Tukar>.from(json["tukar"].map((x) => Tukar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "nama_lengkap": namaLengkap,
        "rt": rt,
        "rw": rw,
        "wa": wa,
        "rool": rool,
        "poin": poin,
        "password": password,
        "foto_profil": fotoProfil,
        "token": token,
        // "kirim": List<dynamic>.from(kirim!.map((x) => x.toJson())),
        // "tukar": List<dynamic>.from(tukar!.map((x) => x.toJson())),
      };
}

// class Kirim {
//   Kirim({
//     this.id,
//     this.tanggal,
//     this.poin,
//     this.jumlah,
//     this.status,
//   });

//   String? id;
//   String? tanggal;
//   int? poin;
//   String? jumlah;
//   String? status;

//   factory Kirim.fromJson(Map<String, dynamic> json) => Kirim(
//         id: json["id"],
//         tanggal: json["tanggal"],
//         poin: json["poin"],
//         jumlah: json["jumlah"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "tanggal": tanggal,
//         "poin": poin,
//         "jumlah": jumlah,
//         "status": status,
//       };
// }

// class Tukar {
//   Tukar({
//     this.id,
//     this.tanggal,
//     this.poin,
//   });

//   String? id;
//   String? tanggal;
//   int? poin;

//   factory Tukar.fromJson(Map<String, dynamic> json) => Tukar(
//         id: json["id"],
//         tanggal: json["tanggal"],
//         poin: json["poin"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "tanggal": tanggal,
//         "poin": poin,
//       };
// }
