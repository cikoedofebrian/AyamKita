import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  UserModel? _user;
  UserModel get user => _user!;
  // String _name = '';
  // String _role = '';
  // String _email = '';
  // String _farmId = '';
  // String _number = '';
  // String _address = '';
  // String _since = '';
  // String _farmName = '';
  // String _imageUrl = '';

  // String get name => _name;
  // String get role => _role;
  // String get email => _email;
  // String get farmId => _farmId;
  // String get number => _number;
  // String get address => _address;
  // String get since => _since;
  // String get farmName => _farmName;
  // String get imageUrl => _imageUrl;

  Future<void> fetchData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        // final result = await FirebaseFirestore.instance
        //     .collection('account')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .get();

        final result = await FirebaseFirestore.instance
            .collection('akun')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

        _user = UserModel.fromJson(result.data()!);
        // print(user);

        // final parsedData = result.data().toString();
        // _name = result['name'];
        // _role = result['role'];
        // _email = result['email'];

        // final farmData = await FirebaseFirestore.instance
        //     .collection('farms')
        //     .where('workerId',
        //         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        //     .limit(1)
        //     .get();

        // _farmId = farmData.docs[0].reference.id;
        // _farmName = farmData.docs[0]['name'];
        // _number =
        //     parsedData.contains('number') ? result['number'].toString() : '';
        // _address = parsedData.contains('address') ? result['address'] : '';
        // _since = parsedData.contains('since') ? result['since'] : '';
        // _imageUrl = parsedData.contains('imageUrl') ? result['imageUrl'] : '';
        // _number = result['number'] ?? '';
        // _address = result['address'] ?? '';
        // _since = result['since'] ?? '';
      }
    } catch (error) {
      print(error);
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
          'number': int.parse(number)
        },
      );
      user.nama = nama;
      user.noTelepon = number;
      user.alamat = alamat;
      user.downloadUrl = downloadUrl;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
