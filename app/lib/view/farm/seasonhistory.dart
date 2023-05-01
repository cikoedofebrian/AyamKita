import 'package:app/constant/appcolor.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/farmcontroller.dart';
import 'package:app/model/dataharianmodel.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/datalist.dart';
import 'package:app/widget/sessionwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeasonHistory extends StatefulWidget {
  const SeasonHistory({super.key});

  @override
  State<SeasonHistory> createState() => _SeasonHistoryState();
}

class _SeasonHistoryState extends State<SeasonHistory> {
  // bool isSpecific = false;
  // late List<DataHarianModel> list;
  // @override
  // void initState() {
  //   list = Provider.of<DailyController>(context, listen: false).list;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final seasonList =
        Provider.of<DailyController>(context, listen: false).musimList;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: seasonList.isEmpty
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
                    itemCount: seasonList.length,
                    itemBuilder: (context, index) => SessionWidget(
                      tipe: seasonList[index].tipe,
                      jumlah: seasonList[index].jumlah.toString(),
                      tanggal: seasonList[index].mulai.toString(),
                      index: index,
                    ),
                  ),
          ),
          const CustomBackButton(color: AppColor.secondary),
        ],
      ),
    );
  }
}
