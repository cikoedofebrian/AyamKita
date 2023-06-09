import 'package:app/constant/app_color.dart';
import 'package:app/constant/app_format.dart';
import 'package:app/controller/c_data_harian.dart';
import 'package:app/model/m_data_harian.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/data_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DataHarian extends StatefulWidget {
  const DataHarian({super.key});

  @override
  State<DataHarian> createState() => _DataHarianState();
}

class _DataHarianState extends State<DataHarian> {
  bool isOnSpecificDate = false;
  List<MDataHarian> specificData = [];
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;
    var cDataHarian = Provider.of<CDataHarian>(context, listen: false);
    var dataHarian = isOnSpecificDate
        ? specificData
        : Provider.of<CDataHarian>(context, listen: false).getDataHarian(index);

    void tryPickDate() {
      final startDate =
          AppFormat.stringtoDateTime(cDataHarian.musimList[index].mulai);
      showDatePicker(
              context: context,
              initialDate: startDate,
              firstDate: startDate,
              lastDate: DateTime(startDate.year + 1))
          .then(
        (value) {
          if (value != null) {
            final getSpecificData = cDataHarian.getTanggal(value, index);
            setState(() {
              isOnSpecificDate = true;
              specificData = getSpecificData == null ? [] : [getSpecificData];
            });
          }
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: dataHarian.isEmpty
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
                // : specificData != null
                //     ? Padding(
                //         padding: const EdgeInsets.only(
                //             top: 120, left: 40, right: 40, bottom: 20),
                //         child: DataList(
                //           tanggal:
                //               AppFormat.stringtoDateTime(specificData!.tanggal),
                //           umur: specificData!.umur,
                //           keluar: specificData!.keluar,
                //           pakan: specificData!.pakan,
                //           hargaObat: specificData!.hargaObat,
                //           hargaPakan: specificData!.hargaPakan,
                //           kematian: specificData!.kematian,
                //           obat: specificData!.obat,
                //         ),
                //       )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 120, left: 40, right: 40, bottom: 20),
                    itemCount: dataHarian.length,
                    itemBuilder: (context, index) => DataList(
                      keluar: dataHarian[index].keluar,
                      kematian: dataHarian[index].kematian,
                      obat: dataHarian[index].obat,
                      pakan: dataHarian[index].pakan,
                      hargaObat: dataHarian[index].hargaObat,
                      hargaPakan: dataHarian[index].hargaPakan,
                      tanggal: DateFormat("dd-MM-yyyy")
                          .parse(dataHarian[index].tanggal),
                      umur: dataHarian[index].umur,
                    ),
                  ),
          ),
          const CustomBackButton(
            color: AppColor.secondary,
          ),
          Positioned(
            top: 50,
            right: 40,
            child: Material(
              borderRadius: BorderRadius.circular(100),
              elevation: 4,
              child: InkWell(
                onTap: tryPickDate,
                child: const CircleAvatar(
                  radius: 27,
                  backgroundColor: AppColor.secondary,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.tertiary,
                    child: Icon(
                      Icons.calendar_month,
                      color: AppColor.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
