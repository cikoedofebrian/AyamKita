import 'package:app/constant/appformat.dart';
import 'package:app/model/workinghours.dart';

class FindDoctorModel {
  String dokterId;
  String deskripsi;
  String imageUrl;
  String lokasi;
  String nama;
  int harga;
  List<WorkingHours> hoursList;

  FindDoctorModel({
    required this.nama,
    required this.imageUrl,
    required this.dokterId,
    required this.lokasi,
    required this.hoursList,
    required this.deskripsi,
    required this.harga,
  });

  factory FindDoctorModel.fromJson(Map<String, dynamic> json,
          Map<String, dynamic> json2, String id, List<WorkingHours> list) =>
      FindDoctorModel(
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
