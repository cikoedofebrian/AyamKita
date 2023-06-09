class MDataHarian {
  final String tanggal;
  final int umur;
  final double pakan;
  final int hargaPakan;
  final int kematian;
  final int keluar;
  final String obat;
  final int hargaObat;
  final int harga;

  MDataHarian({
    required this.tanggal,
    required this.umur,
    required this.hargaObat,
    required this.hargaPakan,
    required this.keluar,
    required this.obat,
    required this.pakan,
    required this.kematian,
    required this.harga,
  });

  factory MDataHarian.fromJson(Map<String, dynamic> json) {
    return MDataHarian(
      tanggal: json['tanggal'],
      kematian: json['kematian'],
      umur: json['umur'],
      pakan: json['pakan'],
      keluar: json['keluar'],
      obat: json['obat'] ?? '',
      hargaObat: json['harga_obat'],
      hargaPakan: json['harga_pakan'],
      harga: json['harga'],
    );
  }
}
