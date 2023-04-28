import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ConsultationRequestModel {
  String peternakanId;
  String pengelolaId;
  String judul;
  String deskripsi;
  String tanggal;

  ConsultationRequestModel({
    required this.peternakanId,
    required this.deskripsi,
    required this.judul,
    required this.pengelolaId,
    required this.tanggal,
  });

  factory ConsultationRequestModel.fromJson(Map<String, dynamic> json) {
    return ConsultationRequestModel(
        deskripsi: json['deskripsi'] ?? '',
        judul: json['judul'] ?? '',
        pengelolaId: json['pengelolaId'] ?? '',
        peternakanId: json['peternakanId'] ?? '',
        tanggal: json['tanggal'] ?? '');
  }

  Future<String?> imageUrl() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('account')
          .doc(pengelolaId)
          .get();
      return result.data()!['imageUrl'];
      // final imageUrl = result.data()![0]['imageUrl'];
    } catch (error) {
      print(error);
      return null;
    }
  }
}
