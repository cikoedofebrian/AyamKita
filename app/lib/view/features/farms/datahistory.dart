import 'package:app/constant/appcolor.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/model/dataharianmodel.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/datalist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataHistory extends StatefulWidget {
  const DataHistory({super.key});

  @override
  State<DataHistory> createState() => _DataHistoryState();
}

class _DataHistoryState extends State<DataHistory> {
  bool isSpecific = false;
  late List<DataHarianModel> list;
  @override
  void initState() {
    list = Provider.of<DailyController>(context, listen: false).list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void chooseSpecific(DateTime dateTime) {
      final data = Provider.of<DailyController>(context, listen: false).list;
      for (var i in data) {
        if (i.tanggal == dateTime) {
          setState(() {
            list = [i];
          });
          return;
        }
      }
      setState(() {
        list = [];
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: list.isEmpty
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
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 120, left: 40, right: 40, bottom: 20),
                    itemCount: list.length,
                    itemBuilder: (context, index) => DataList(
                      datang: list[index].datang,
                      kematian: list[index].kematian,
                      obat: list[index].obat,
                      pakai: list[index].pakai,
                      panen: list[index].panen,
                      std: list[index].std,
                      stok: list[index].stok,
                      tanggal: list[index].tanggal,
                      umur: list[index].umur,
                    ),
                  ),
          ),
          CustomBackButton(color: AppColor.secondary),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  backgroundColor: AppColor.secondary,
                  radius: 27,
                  child: CircleAvatar(
                    backgroundColor: AppColor.tertiary,
                    radius: 25,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(
                        Icons.calendar_month_rounded,
                        color: AppColor.secondary,
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                        ).then((value) {
                          if (value != null) {
                            chooseSpecific(value);
                          }
                        });
                      },
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
