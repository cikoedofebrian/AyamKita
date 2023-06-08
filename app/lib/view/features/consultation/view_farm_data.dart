import 'package:app/constant/appcolor.dart';
import 'package:app/model/dataharianmodel.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/datalist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ViewFarmData extends StatelessWidget {
  const ViewFarmData({super.key});

  @override
  Widget build(BuildContext context) {
    final musimId = ModalRoute.of(context)!.settings.arguments as String;
    Future<List<DataHarianModel>> fetchData() async {
      final result = await FirebaseFirestore.instance
          .collection('data_harian')
          // .orderBy('tanggal', descending: false)
          .where('musimId', isEqualTo: musimId)
          .get();
      List<DataHarianModel> emptyList = [];

      for (var e in result.docs) {
        final newData = DataHarianModel.fromJson(e.data());
        emptyList.add(newData);
      }
      emptyList.sort((a, b) => DateFormat('dd-MM-yyyy')
          .parse(a.tanggal)
          .compareTo(DateFormat('dd-MM-yyyy').parse(b.tanggal)));
      return emptyList;
    }

    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: AppColor.secondary, size: 60),
            );
          }

          List<DataHarianModel> realList = snapshot.data!;
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: realList.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum ada data harian.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Coba pilih tanggal lain.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 120, left: 40, right: 40, bottom: 20),
                        itemCount: realList.length,
                        itemBuilder: (context, index) => DataList(
                          keluar: realList[index].keluar,
                          kematian: realList[index].kematian,
                          obat: realList[index].obat,
                          pakan: realList[index].pakan,
                          hargaObat: realList[index].hargaObat,
                          hargaPakan: realList[index].hargaPakan,
                          tanggal: DateFormat("dd-MM-yyyy")
                              .parse(realList[index].tanggal),
                          umur: realList[index].umur,
                        ),
                      ),
              ),
              const CustomBackButton(color: AppColor.secondary),
            ],
          );
        },
        future: fetchData(),
      ),
    );
  }
}
