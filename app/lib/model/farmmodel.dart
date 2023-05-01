class PeternakanModel {
  final String peternakanId;
  final String nama;
  final String semenjak;
  final int luas;
  final String alamat;
  final String downloadUrl;

  PeternakanModel({
    required this.peternakanId,
    required this.nama,
    required this.semenjak,
    required this.luas,
    required this.alamat,
    required this.downloadUrl,
  });

  factory PeternakanModel.fromJson(Map<String, dynamic> json, id) {
    return PeternakanModel(
      peternakanId: id,
      alamat: json['alamat'],
      luas: json['luas'],
      nama: json['nama'],
      semenjak: json['semenjak'],
      downloadUrl: json.containsKey('downloadUrl') ? json['downloadUrl'] : '',
    );
  }
}
