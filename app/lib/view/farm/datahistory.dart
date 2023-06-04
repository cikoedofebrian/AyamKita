import 'package:app/constant/appcolor.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/datalist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DataHistory extends StatefulWidget {
  const DataHistory({super.key});

  @override
  State<DataHistory> createState() => _DataHistoryState();
}

class _DataHistoryState extends State<DataHistory> {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;
    var realList = Provider.of<DailyController>(context, listen: false)
        .musimList[index]
        .list;

    return Scaffold(
      body: Stack(
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
      ),
    );
  }
}
