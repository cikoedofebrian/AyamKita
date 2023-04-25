import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  String _name = '';
  String _role = '';
  String _email = '';
  String _farmId = '';
  String _number = '';
  String _address = '';
  String _since = '';
  String _farmName = '';
  String _imageUrl = '';

  String get name => _name;
  String get role => _role;
  String get email => _email;
  String get farmId => _farmId;
  String get number => _number;
  String get address => _address;
  String get since => _since;
  String get farmName => _farmName;
  String get imageUrl => _imageUrl;

  Future<void> fetchData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final result = await FirebaseFirestore.instance
            .collection('account')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        final parsedData = result.data().toString();
        _name = result['name'];
        _role = result['role'];
        _email = result['email'];

        final farmData = await FirebaseFirestore.instance
            .collection('farms')
            .where('workerId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .limit(1)
            .get();

        _farmId = farmData.docs[0].reference.id;
        _farmName = farmData.docs[0]['name'];
        _number =
            parsedData.contains('number') ? result['number'].toString() : '';
        _address = parsedData.contains('address') ? result['address'] : '';
        _since = parsedData.contains('since') ? result['since'] : '';
        _imageUrl = parsedData.contains('imageUrl') ? result['imageUrl'] : '';
        // _number = result['number'] ?? '';
        // _address = result['address'] ?? '';
        // _since = result['since'] ?? '';
      }
    } catch (error) {
      print(error);
    }
  }

  void updateData(
    String name,
    String number,
    String address,
    String imageUrl,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('account')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'name': name,
          'address': address,
          'imageUrl': imageUrl,
          'number': int.parse(number)
        },
      );
      _name = name;
      _number = number;
      _address = address;
      _imageUrl = imageUrl;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
