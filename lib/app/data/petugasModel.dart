// ignore_for_file: file_names

class PetugasModel {
  final String uid;
  final String email;
  final String namaLengkap;
  final String rool;
  final String password;
  final String token;

  PetugasModel({
    required this.uid,
    required this.email,
    required this.namaLengkap,
    required this.rool,
    required this.password,
    required this.token,
  });

  factory PetugasModel.fromJson(Map<String, dynamic> json) => PetugasModel(
        uid: json["uid"] ?? "",
        email: json["email"] ?? "",
        namaLengkap: json["nama_lengkap"] ?? "",
        rool: json["rool"] ?? "",
        password: json["password"] ?? "",
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "nama_lengkap": namaLengkap,
        "rool": rool,
        "password": password,
        "token": token,
      };
}
