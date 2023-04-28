class UserModel {
  String nama;
  String role;
  String email;
  String peternakanId;
  String noTelepon;
  String alamat;
  String tanggalPendaftaran;
  String downloadUrl;

  UserModel({
    required this.nama,
    required this.role,
    required this.alamat,
    required this.email,
    required this.peternakanId,
    required this.downloadUrl,
    required this.tanggalPendaftaran,
    required this.noTelepon,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nama: json['nama'],
        role: json['role'],
        alamat: json.containsKey('alamat') ? json['alamat'] : '',
        downloadUrl: json.containsKey('downloadUrl') ? json['downloadUrl'] : '',
        email: json['email'],
        noTelepon:
            json.containsKey('noTelepon') ? json['noTelepon'].toString() : '',
        peternakanId: json['peternakanId'],
        tanggalPendaftaran: json['tanggal_pendaftaran'],
      );
}
