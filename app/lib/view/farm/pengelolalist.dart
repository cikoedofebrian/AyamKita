import 'package:app/constant/appcolor.dart';
import 'package:app/controller/farmcontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/pengelolawidget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PengelolaList extends StatelessWidget {
  const PengelolaList({super.key});

  @override
  Widget build(BuildContext context) {
    final peternakanController = Provider.of<PeternakanController>(context);
    return Scaffold(
      body: FutureBuilder(
          future: peternakanController.seePengelola(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.orange, size: 60),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                SizedBox(
                  height: 140,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: AppColor.secondary,
                        height: 130,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 105, top: 25),
                          child: Text(
                            'Daftar Pengelola',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const CustomBackButton(color: AppColor.quaternary),
                    ],
                  ),
                ),
                Expanded(
                    child: snapshot.data!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, top: 10),
                                child: Text(
                                  'Jumlah Pengelola : ${snapshot.data!.length}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  itemBuilder: (context, index) =>
                                      PengelolaWidget(
                                    data: snapshot.data![index],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum ada pengelola',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Buat akun pengelola baru menggunakan ID Peternakan',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
              ]),
            );
          }),
    );
  }
}
