// ignore_for_file: file_names
class TransaksiSampahModel {
  final String id;
  final String email;
  final String nama;
  final String petugas;
  final String tanggal;
  final String status;
  final String rt;
  final String rw;
  final String fotoSampah;
  final double jumlahOrganik;
  final double jumlahAnorganik;
  final int poin;
  final String keterangan;
  final String jenisAnorganik;
  final String tanggalKonfirmasi;
  final String creationTime;
  final String confirmTime;

  TransaksiSampahModel({
    required this.id,
    required this.email,
    required this.nama,
    required this.petugas,
    required this.tanggal,
    required this.status,
    required this.rt,
    required this.rw,
    required this.fotoSampah,
    required this.jumlahOrganik,
    required this.jumlahAnorganik,
    required this.poin,
    required this.keterangan,
    required this.jenisAnorganik,
    required this.tanggalKonfirmasi,
    required this.creationTime,
    required this.confirmTime,
  });

  factory TransaksiSampahModel.fromJson(Map<String, dynamic> json) =>
      TransaksiSampahModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        nama: json["nama"] ?? "",
        petugas: json["petugas"] ?? "",
        tanggal: json["tanggal"] ?? "",
        status: json["status"] ?? "",
        rt: json["rt"] ?? "",
        rw: json["rw"] ?? "",
        fotoSampah: json["foto_sampah"] ?? "",
        jumlahOrganik: json["jumlahOrganik"] ?? 0,
        jumlahAnorganik: json["jumlahAnorganik"] ?? 0,
        poin: json["poin"] ?? 0,
        keterangan: json["keterangan"] ?? "",
        jenisAnorganik: json["jenisAnorganik"] ?? "",
        tanggalKonfirmasi: json["tanggalKonfirmasi"] ?? "",
        creationTime: json["creationTime"] ?? "",
        confirmTime: json["confirmTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nama": nama,
        "petugas": petugas,
        "tanggal": tanggal,
        "status": status,
        "rt": rt,
        "rw": rw,
        "foto_sampah": fotoSampah,
        "jumlah": jumlahOrganik,
        "jumlahAnorganik": jumlahAnorganik,
        "poin": poin,
        "keterangan": keterangan,
        "jenisAnorganik": jenisAnorganik,
        "tanggalKonfirmasi": tanggalKonfirmasi,
        "creationTime": creationTime,
        "confirmTime": confirmTime,
      };
}
