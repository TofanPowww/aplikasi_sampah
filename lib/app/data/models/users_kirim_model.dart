import 'dart:convert';

UsersKirimModel usersModelFromJson(String str) =>
    UsersKirimModel.fromJson(json.decode(str));

String usersModelToJson(UsersKirimModel data) => json.encode(data.toJson());

class UsersKirimModel {
  UsersKirimModel(
      {this.tanggal,
      this.fotoSampah,
      this.jumlah,
      this.poin,
      this.status,
      this.creationTime});

  String? tanggal;
  String? fotoSampah;
  int? jumlah;
  int? poin;
  String? status;
  String? creationTime;

  factory UsersKirimModel.fromJson(Map<String, dynamic> json) =>
      UsersKirimModel(
        tanggal: json["tanggal"],
        fotoSampah: json["foto_sampah"],
        jumlah: json["jumlah"],
        poin: json["poin"],
        status: json["status"],
        creationTime: json["creationTime"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "foto_sampah": fotoSampah,
        "jumlah": jumlah,
        "poin": poin,
        "status": status,
        "creationTime": creationTime
      };
}
