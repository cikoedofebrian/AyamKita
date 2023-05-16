import 'package:app/constant/appcolor.dart';
import 'package:app/widget/consultationdata.dart';
import 'package:app/widget/customtop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final hasilId = ModalRoute.of(context)!.settings.arguments as String;

    return Theme(
      data: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          outlineBorder: BorderSide(color: Colors.grey),
          disabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          filled: true,
          fillColor: AppColor.formcolor,
        ),
      ),
      child: Scaffold(
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('hasil_konsultasi')
                .doc(hasilId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: AppColor.tertiary, size: 60),
                );
              }
              final fetchedData = snapshot.data!.data()!;
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConsultationDataWidget(
                            title: 'Tanggal',
                            data: fetchedData['tanggal'],
                            moreThanOneLine: false),
                        ConsultationDataWidget(
                            title: 'Diagnosa',
                            data: fetchedData['diagnosa'],
                            moreThanOneLine: false),
                        ConsultationDataWidget(
                            data: fetchedData['penjelasan'],
                            title: 'Penjelasan',
                            moreThanOneLine: true),
                      ],
                    ),
                  ),
                  const CustomTop(title: 'Hasil Konsultasi')
                ],
              );
            }),
      ),
    );
  }
}
