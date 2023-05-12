import 'package:app/constant/role.dart';
import 'package:app/model/farmmodel.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConsultationModel {
  final String konsultasiId;
  final String peternakanId;
  final String usulanKonsultasiId;
  final String status;
  final int harga;
  final String dokterId;
  final DateTime tanggal;
  final String hasilId;

  ConsultationModel({
    required this.dokterId,
    required this.harga,
    required this.hasilId,
    required this.konsultasiId,
    required this.peternakanId,
    required this.status,
    required this.tanggal,
    required this.usulanKonsultasiId,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json, id) {
    return ConsultationModel(
      dokterId: json['dokterId'],
      harga: json['harga'],
      hasilId: json['hasilId'],
      tanggal: DateFormat('dd-MM-yyyy').parse(json['date']),
      konsultasiId: json['usulanKonsultasiId'],
      peternakanId: json['peternakanId'],
      status: json['status'],
      usulanKonsultasiId: json['usulanKonsultasiId'],
    );
  }

  Future<UserModel> getData(String role) async {
    if (role == UserRole.pemilik) {
      final result = await FirebaseFirestore.instance
          .collection('akun')
          .where('peternakanId', isEqualTo: peternakanId)
          .limit(0)
          .get();
      return UserModel.fromJson(result.docs[0].data());
    } else {
      final result = await FirebaseFirestore.instance
          .collection('akun')
          .doc(dokterId)
          .get();
      return UserModel.fromJson(result.data()!);
    }
  }

  Future<PeternakanModel> getFarmData() async {
    final result = await FirebaseFirestore.instance
        .collection('peternakan')
        .doc(peternakanId)
        .get();
    return PeternakanModel.fromJson(result.data()!, result.id);
  }
}
