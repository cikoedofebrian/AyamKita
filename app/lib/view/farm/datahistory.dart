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

    void chooseSpecific(DateTime dateTime) {
      var list = Provider.of<DailyController>(context, listen: false)
          .musimList[index]
          .list;
      for (var i in list) {
        if (DateFormat("dd-MM-yyyy").parse(i.tanggal) == dateTime) {
          setState(() {
            realList = [i];
          });
          return;
        }
      }
      setState(() {
        realList = [];
      });

      print(realList.length);
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: realList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                // : null
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
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          //     child: Material(
          //       elevation: 4,
          //       borderRadius: BorderRadius.circular(100),
          //       child: CircleAvatar(
          //         backgroundColor: AppColor.secondary,
          //         radius: 27,
          //         child: CircleAvatar(
          //           backgroundColor: AppColor.tertiary,
          //           radius: 25,
          //           child: IconButton(
          //             iconSize: 30,
          //             icon: const Icon(
          //               Icons.calendar_month_rounded,
          //               color: AppColor.secondary,
          //             ),
          //             onPressed: () {
          //               showDatePicker(
          //                 context: context,
          //                 initialDate: DateTime.now(),
          //                 firstDate: DateTime(DateTime.now().year - 1),
          //                 lastDate: DateTime(DateTime.now().year + 1),
          //               ).then((value) {
          //                 if (value != null) {
          //                   chooseSpecific(value);
          //                 }
          //               });
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
