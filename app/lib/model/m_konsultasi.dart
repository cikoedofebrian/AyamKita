import 'package:app/constant/role.dart';
import 'package:app/model/m_usulan_konsultasi.dart';
import 'package:app/model/m_peternakan.dart';
import 'package:app/model/m_akun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MKonsultasi {
  final String konsultasiId;
  final String peternakanId;
  final String usulanKonsultasiId;
  String status;
  final int harga;
  final String dokterId;
  final DateTime tanggal;
  String hasilId;

  MKonsultasi({
    required this.dokterId,
    required this.harga,
    required this.hasilId,
    required this.konsultasiId,
    required this.peternakanId,
    required this.status,
    required this.tanggal,
    required this.usulanKonsultasiId,
  });

  factory MKonsultasi.fromJson(Map<String, dynamic> json, id) {
    return MKonsultasi(
      dokterId: json['dokterId'],
      harga: json['harga'],
      hasilId: json.containsKey('hasilId') ? json['hasilId'] : '',
      tanggal: DateFormat('dd-MM-yyyy').parse(json['date']),
      konsultasiId: id,
      peternakanId: json['peternakanId'],
      status: json['status'],
      usulanKonsultasiId: json['usulanKonsultasiId'],
    );
  }

  Future<MAkun> getData(String role) async {
    if (role == UserRole.pemilik) {
      final result = await FirebaseFirestore.instance
          .collection('akun')
          .where('peternakanId', isEqualTo: peternakanId)
          .limit(0)
          .get();
      return MAkun.fromJson(result.docs[0].data(), result.docs[0].id);
    } else {
      final result = await FirebaseFirestore.instance
          .collection('akun')
          .doc(dokterId)
          .get();
      return MAkun.fromJson(result.data()!, result.id);
    }
  }

  Future<MPeternakan> getFarmData() async {
    final result = await FirebaseFirestore.instance
        .collection('peternakan')
        .doc(peternakanId)
        .get();
    return MPeternakan.fromJson(result.data()!, result.id);
  }

  Future<MUsulanKonsultasi> getConsultationRequest() async {
    final result = await FirebaseFirestore.instance
        .collection('usulan_konsultasi')
        .doc(usulanKonsultasiId)
        .get();

    return MUsulanKonsultasi.fromJson(result.data()!, result.id);
  }

  Future<Map<String, dynamic>> getHasil() async {
    final result = await FirebaseFirestore.instance
        .collection('hasil-konsultasi')
        .doc(hasilId)
        .get();
    return result.data()!;
  }
}
