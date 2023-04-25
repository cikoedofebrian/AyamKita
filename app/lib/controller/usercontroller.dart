import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  String _name = '';
  String _role = '';
  String _email = '';
  String _farmId = '';

  String get name => _name;
  String get role => _role;
  String get email => _email;
  String get farmId => _farmId;

  Future<void> fetchData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final result = await FirebaseFirestore.instance
          .collection('account')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      _name = result['name'];
      _role = result['role'];
      _email = result['email'];
      _farmId = result['farmId'];
    }
  }
}
