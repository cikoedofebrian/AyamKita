import 'package:app/constant/appformat.dart';
import 'package:app/constant/role.dart';
import 'package:app/model/usermodel.dart';
import 'package:app/model/workinghours.dart';
import 'package:app/widget/customdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CAuth extends ChangeNotifier {
  UserModel? _user;
  UserModel getDataProfile() {
    return _user!;
  }

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

  Future<bool> validasiForm(
    BuildContext context,
    GlobalKey<FormState> formKey,
    String email,
    String password,
    String alamat,
    String name,
  ) async {
    formKey.currentState!.save();
    if (email.isEmpty || password.isEmpty || name.isEmpty || alamat.isEmpty) {
      customDialog(context, 'Gagal', 'Data tidak boleh kosong!');
      return false;
    } else if (!EmailValidator.validate(email)) {
      customDialog(context, 'Gagal', 'Email tidak valid!');
      return false;
    } else if (password.length < 8) {
      customDialog(
          context, 'Gagal', 'Password tidak boleh kurang dari 8 karakter!');
      return false;
    } else {
      final checkEmail =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (checkEmail.isNotEmpty) {
        // ignore: use_build_context_synchronously
        customDialog(context, 'Gagal', 'Email sudah terdaftar!');
        return false;
      }
      return true;
    }
  }

  Future<void> fetchDokterDetails() async {
    final result = await FirebaseFirestore.instance
        .collection('dokter-details')
        .doc(_user!.dokterDetailsId)
        .get();
    _deskripsi = result.data()!['deskripsi'];
    _harga = result.data()!['harga'];
  }

  Future<UserModel> getUserFromId(String userId) async {
    final result =
        await FirebaseFirestore.instance.collection('akun').doc(userId).get();
    return UserModel.fromJson(result.data()!, result.id);
  }

  Future<void> fetchData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final result = await FirebaseFirestore.instance
          .collection('akun')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      _user = UserModel.fromJson(result.data()!, result.id);
    }
  }

  Future<String> getFarmName() async {
    final result = await FirebaseFirestore.instance
        .collection('peternakan')
        .doc(_user!.peternakanId)
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
      rethrow;
    }
  }

  void resumeLogin(BuildContext context, GlobalKey<FormState> formKey,
      String email, String password) async {
    formKey.currentState!.save();
    if (email.isEmpty || password.isEmpty) {
      customDialog(context, 'Gagal', 'Data tidak bolek kosong!');
      return;
    } else if (!EmailValidator.validate(email)) {
      customDialog(context, 'Gagal', 'Data tidak valid!');
      return;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (error) {
      if (error.code == 'wrong-password' || error.code == 'user-not-found') {
        customDialog(context, 'Gagal', 'Email/Password salah!');
      } else {
        customDialog(
            context, 'Gagal', 'Terdapat kesalahan sistem, coba lagi nanti');
      }
    }
  }

  Future<List<UserModel>> getUserData(String role) async {
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('role', isEqualTo: UserRole.pemilik)
        .limit(1)
        .get();
    return [UserModel.fromJson(data.docs[0].data(), data.docs[0].id)];
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
    _user!.nama = nama;
    _user!.noTelepon = number;
    _user!.alamat = alamat;
    _user!.downloadUrl = downloadUrl;
    notifyListeners();
  }
}
