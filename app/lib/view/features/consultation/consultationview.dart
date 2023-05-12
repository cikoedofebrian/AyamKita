import 'package:app/constant/role.dart';
import 'package:app/controller/farmcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/model/farmmodel.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultationView extends StatelessWidget {
  const ConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final userController = Provider.of<UserController>(context, listen: false);
    final peternakanData = data[0] as PeternakanModel;
    final dokterData = data[1] as UserModel;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          UserModel continuedData = dokterData;
          if (userController.user.role == UserRole.dokter) {
            final data = await FirebaseFirestore.instance
                .collection('akun')
                .where('peternakanId', isEqualTo: peternakanData.peternakanId)
                .where('role', isEqualTo: UserRole.pemilik)
                .limit(1)
                .get();

            continuedData = UserModel.fromJson(
              data.docs[0].data(),
            );
          }
          Navigator.pushNamed(context, '/chat-view', arguments: continuedData);
        },
      ),
      body: Column(children: [
        Text((data[0] as PeternakanModel).nama),
      ]),
    );
  }
}
