class MPeternakan {
  final String peternakanId;
  String nama;
  final String semenjak;
  int luas;
  String alamat;
  String downloadUrl;

  MPeternakan({
    required this.peternakanId,
    required this.nama,
    required this.semenjak,
    required this.luas,
    required this.alamat,
    required this.downloadUrl,
  });

  factory MPeternakan.fromJson(Map<String, dynamic> json, id) {
    return MPeternakan(
      peternakanId: id,
      alamat: json['alamat'],
      luas: json['luas'],
      nama: json['nama'],
      semenjak: json['semenjak'],
      downloadUrl: json.containsKey('downloadUrl') ? json['downloadUrl'] : '',
    );
  }
}
