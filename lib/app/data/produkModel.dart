// ignore_for_file: file_names

class ProdukModel {
  final String produkId;
  final String nama;
  final int poin;
  final String deskripsi;

  ProdukModel({
    required this.produkId,
    required this.nama,
    required this.poin,
    required this.deskripsi,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
        produkId: json["produk_id"] ?? "",
        nama: json["nama"] ?? "",
        poin: json["poin"] ?? 0,
        deskripsi: json["deskripsi"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "produk_id": produkId,
        "nama": nama,
        "poin": poin,
        "deskripsi": deskripsi,
      };
}
