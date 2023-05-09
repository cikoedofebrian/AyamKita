import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/workinghourscontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkingHoursWiget extends StatelessWidget {
  const WorkingHoursWiget({super.key});

  @override
  Widget build(BuildContext context) {
    final workingHoursController =
        Provider.of<WorkingHoursControllers>(context).list;
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
            const SizedBox(
              height: 25,
            ),
            ...workingHoursController
                .map((e) => Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 20),
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
                                AppFormat.getWeekName(e.day),
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Text(
                              '${AppFormat.dayTimeToString(e.mulai)} - ${AppFormat.dayTimeToString(e.berakhir)}'),
                        ],
                      ),
                    ))
                .toList(),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed('/change-work-hours'),
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
                  "Ubah Jam Kerja",
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
