import 'package:app/constant/app_format.dart';
import 'package:app/model/m_jam_kerja.dart';

class MDokter {
  String dokterId;
  String deskripsi;
  String imageUrl;
  String lokasi;
  String nama;
  int harga;
  List<MJamKerja> hoursList;

  MDokter({
    required this.nama,
    required this.imageUrl,
    required this.dokterId,
    required this.lokasi,
    required this.hoursList,
    required this.deskripsi,
    required this.harga,
  });

  factory MDokter.fromJson(Map<String, dynamic> json,
          Map<String, dynamic> json2, String id, List<MJamKerja> list) =>
      MDokter(
        deskripsi: json['deskripsi'],
        dokterId: id,
        harga: json['harga'],
        hoursList: list,
        imageUrl: json2.containsKey('downloadUrl') ? json2['downloadUrl'] : "",
        lokasi: json2['alamat'],
        nama: json2['nama'],
      );

  bool ifCurrentlyOpen(int currentDay) {
    final ifOpen = hoursList.indexWhere((element) => element.day == currentDay);
    if (ifOpen != -1) {
      if (AppFormat.isBetween(
          hoursList[ifOpen].mulai, hoursList[ifOpen].berakhir)) {
        return true;
      }
    }
    return false;
  }
}
