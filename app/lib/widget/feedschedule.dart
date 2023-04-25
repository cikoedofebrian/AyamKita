import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/feedcontroller.dart';
import 'package:app/helper/customexception.dart';
import 'package:app/widget/customdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class FeedSchedule extends StatelessWidget {
  const FeedSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final feedController = Provider.of<FeedController>(context);
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppColor.tertiary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25, bottom: 20),
              child: Text(AppFormat.fDate(feedController.list[0].date)),
            ),
            ...List.generate(
              2,
              (index) {
                final firstData = feedController.list[0];
                return Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              index == 0
                                  ? AppFormat.feedDate(
                                      firstData.time['first'], index)
                                  : AppFormat.feedDate(
                                      firstData.time['second'], index),
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Icon(
                          Icons.check_circle_rounded,
                          size: 38,
                          color: firstData.isfeeded[index] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ));
              },
            ),
            GestureDetector(
              onTap: () {
                try {
                  feedController.fillAbsence();
                  customDialog(context, "Berhasil!",
                      "Presensi pakan telah berhasil ditambahkan!");
                } catch (error) {
                  if (error is CustomException) {
                    NDialog(
                      dialogStyle: DialogStyle(titleDivider: true),
                      title: const Text(
                        "Error!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(error.message)),
                      actions: [
                        TextButton(
                            child: const Text(
                              "Tutup",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ).show(context);
                  }
                }
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: AppColor.secondary,
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.secondary,
                      AppColor.tertiary,
                    ],
                  ),
                ),
                child: const Text(
                  "Isi Jadwal Pakan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
