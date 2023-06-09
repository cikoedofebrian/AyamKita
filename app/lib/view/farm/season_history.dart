import 'package:app/constant/app_color.dart';
import 'package:app/controller/c_data_harian.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/session_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeasonHistory extends StatefulWidget {
  const SeasonHistory({super.key});

  @override
  State<SeasonHistory> createState() => _SeasonHistoryState();
}

class _SeasonHistoryState extends State<SeasonHistory> {
  @override
  Widget build(BuildContext context) {
    final seasonList =
        Provider.of<CDataHarian>(context, listen: false).musimList;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: seasonList.isEmpty
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
                    itemCount: seasonList.length,
                    itemBuilder: (context, index) => SessionWidget(
                      tipe: seasonList[index].tipe,
                      jumlah: seasonList[index].jumlah.toString(),
                      tanggal: seasonList[index].mulai.toString(),
                      index: index,
                    ),
                  ),
          ),
          const CustomBackButton(
            color: AppColor.secondary,
          ),
        ],
      ),
    );
  }
}
