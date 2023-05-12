import 'package:app/constant/appformat.dart';
import 'package:app/constant/role.dart';
import 'package:app/model/usermodel.dart';
import 'package:app/model/workinghours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  UserModel? _user;
  UserModel get user => _user!;
  String _deskripsi = '';
  String get deskripsi => _deskripsi;
  int _harga = 0;
  int get harga => _harga;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoading(bool newLoading) {
    _isLoading = newLoading;
    notifyListeners();
  }

  Future<void> fetchDokterDetails() async {
    try {
      // print(user.dokterDetailsId);
      // print(FirebaseAuth.instance.currentUser!.uid);
      final result = await FirebaseFirestore.instance
          .collection('dokter-details')
          .doc(user.dokterDetailsId)
          .get();
      _deskripsi = result.data()!['deskripsi'];
      _harga = result.data()!['harga'];
    } catch (error) {
      print(error);
    }
  }

  Future<UserModel> getUserFromId(String userId) async {
    final result =
        await FirebaseFirestore.instance.collection('akun').doc(userId).get();
    return UserModel.fromJson(result.data()!);
  }

  Future<void> fetchData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final result = await FirebaseFirestore.instance
            .collection('akun')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

        _user = UserModel.fromJson(result.data()!);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<String> getFarmName() async {
    final result = await FirebaseFirestore.instance
        .collection('peternakan')
        .doc(user.peternakanId)
        .get();
    return result.data()!['nama'];
  }

  Future<String?> register(
    String email,
    String nama,
    String password,
    String role,
    String? peternakanId,
    String? doktorDetailsId,
    String tanggalLahir,
    String alamat,
  ) async {
    try {
      final onAuth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('akun')
          .doc(onAuth.user!.uid)
          .set({
        'email': email,
        'nama': nama,
        'role': role,
        'peternakanId': peternakanId,
        'dokterDetailsId': doktorDetailsId,
        'alamat': alamat,
        'tanggal_lahir': tanggalLahir,
        'tanggal_pendaftaran': AppFormat.intDateFromDateTime(DateTime.now())
      });
      return onAuth.user!.uid;
    } on FirebaseAuthException catch (error) {
      print(error);
      rethrow;
    } catch (error) {
      print(error);
    }
  }

  Future<bool> checkPeternakanId(String id) async {
    final checkEmail =
        await FirebaseFirestore.instance.collection('peternakan').doc(id).get();
    if (checkEmail.data() != null) {
      return true;
    }
    return false;
  }

  Future<String> addDokterData(String deksripsi, int harga) async {
    final result =
        await FirebaseFirestore.instance.collection('dokter-details').add({
      'deskripsi': deksripsi,
      'harga': harga,
    });
    return result.id;
  }

  Future<void> addJamKerja(String userId, List<WorkingHours> list) async {
    try {
      for (var element in list) {
        await FirebaseFirestore.instance.collection('jam-kerja').add({
          'dokterId': userId,
          'hari': element.day,
          'mulai': AppFormat.dayTimeToString(element.mulai),
          'berakhir': AppFormat.dayTimeToString(element.berakhir)
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<UserModel>> getUserData(String role) async {
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('role', isEqualTo: UserRole.pemilik)
        .limit(1)
        .get();
    return [UserModel.fromJson(data.docs[0].data())];
  }

  Future<String> addNewFarm(String nama, String alamat, int luas,
      String semenjak, String pagi, String sore) async {
    try {
      final onFirestore =
          await FirebaseFirestore.instance.collection('peternakan').add({
        'nama': nama,
        'luas': luas,
        'alamat': alamat,
        'semenjak': semenjak,
      });
      await FirebaseFirestore.instance.collection('skema_jadwal').add({
        'peternakanId': onFirestore.id,
        'pagi': pagi,
        'sore': sore,
        'tanggal_dibuat': AppFormat.intDateFromDateTime(DateTime.now())
      });
      return onFirestore.id;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  void updateData(
    String nama,
    String number,
    String alamat,
    String downloadUrl,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('akun')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'nama': nama,
          'alamat': alamat,
          'downloadUrl': downloadUrl,
          'noTelepon': int.parse(number)
        },
      );
      user.nama = nama;
      user.noTelepon = number;
      user.alamat = alamat;
      user.downloadUrl = downloadUrl;
      notifyListeners();
      print("this is here");
    } catch (error) {
      print(error);
    }
  }
}
