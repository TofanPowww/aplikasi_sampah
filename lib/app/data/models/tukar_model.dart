// To parse this JSON data, do
//
//     final tukarModel = tukarModelFromJson(jsonString);

import 'dart:convert';

TukarModel tukarModelFromJson(String str) => TukarModel.fromJson(json.decode(str));

String tukarModelToJson(TukarModel data) => json.encode(data.toJson());

class TukarModel {
    TukarModel({
        this.idTukar,
        this.email,
        this.nama,
        this.idProduk,
        this.poin,
        this.creationTime,
    });

    String? idTukar;
    String? email;
    String? nama;
    String? idProduk;
    String? poin;
    String? creationTime;

    factory TukarModel.fromJson(Map<String, dynamic> json) => TukarModel(
        idTukar: json["id_tukar"],
        email: json["email"],
        nama: json["nama"],
        idProduk: json["id_produk"],
        poin: json["poin"],
        creationTime: json["creationTime"],
    );

    Map<String, dynamic> toJson() => {
        "id_tukar": idTukar,
        "email": email,
        "nama": nama,
        "id_produk": idProduk,
        "poin": poin,
        "creationTime": creationTime,
    };
}
