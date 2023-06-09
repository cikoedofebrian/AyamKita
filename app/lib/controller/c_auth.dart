import 'dart:io';
import 'package:app/constant/app_format.dart';
import 'package:app/constant/role.dart';
import 'package:app/model/m_akun.dart';
import 'package:app/model/m_jam_kerja.dart';
import 'package:app/widget/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CAuth extends ChangeNotifier {
  MAkun? _user;
  MAkun getDataProfile() {
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

  void updateDataProfile(
    BuildContext context,
    GlobalKey<FormState> formKey,
    File? photo,
    String imageUrl,
    String name,
    String address,
    String number,
  ) async {
    if (formKey.currentState!.validate()) {
      bool isConfirm = false;
      await NDialog(
        title: const Text(
          'Konfirmasi',
          textAlign: TextAlign.center,
        ),
        content: const Text("Apakah yakin ingin menyimpan data?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              isConfirm = true;
              Navigator.of(context).pop();
            },
            child: const Text('Iya'),
          )
        ],
      ).show(context);
      if (isConfirm) {
        formKey.currentState!.save();
        if (photo != null) {
          final upload = await FirebaseStorage.instance
              .ref('/profile-images/${FirebaseAuth.instance.currentUser!.uid}')
              .putFile(
                File(photo.path),
              );
          final url = await upload.ref.getDownloadURL();
          imageUrl = url;
        }

        final trimmedname = name.trim();
        final trimmedaddress = address.trim();
        final trimmedimageUrl = imageUrl.trim();
        final trimmednumber = number.trim();
        if (trimmedname != _user!.nama ||
            trimmedaddress != _user!.alamat ||
            trimmednumber != _user!.noTelepon ||
            trimmedimageUrl != _user!.downloadUrl) {
          await FirebaseFirestore.instance
              .collection('akun')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update(
            {
              'nama': name,
              'alamat': address,
              'downloadUrl': imageUrl,
              'noTelepon': int.parse(number)
            },
          );
          _user!.nama = name;
          _user!.noTelepon = number;
          _user!.alamat = address;
          _user!.downloadUrl = imageUrl;
          notifyListeners();
          // ignore: use_build_context_synchronously
          customDialog(
              context, "Berhasil!", "Perubahan data berhasil dilakukan");
        } else {
          // ignore: use_build_context_synchronously
          customDialog(
              context, "Tidak berhasil", "Tidak ada data yang dirubah");
        }
      }
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

  Future<MAkun> getUserFromId(String userId) async {
    final result =
        await FirebaseFirestore.instance.collection('akun').doc(userId).get();
    return MAkun.fromJson(result.data()!, result.id);
  }

  Future<void> fetchData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final result = await FirebaseFirestore.instance
            .collection('akun')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

        _user = MAkun.fromJson(result.data()!, result.id);
      }
    } catch (error) {
      FirebaseAuth.instance.signOut();
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

  Future<void> addJamKerja(String userId, List<MJamKerja> list) async {
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

  Future<List<MAkun>> getUserData(String role) async {
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('role', isEqualTo: UserRole.pemilik)
        .limit(1)
        .get();
    return [MAkun.fromJson(data.docs[0].data(), data.docs[0].id)];
  }
}
