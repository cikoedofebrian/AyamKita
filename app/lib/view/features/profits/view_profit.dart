import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/widget/profit_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProfit extends StatefulWidget {
  const ViewProfit({super.key});

  @override
  State<ViewProfit> createState() => _ViewProfitState();
}

class _ViewProfitState extends State<ViewProfit> {
  late String musimId = '';

  @override
  void initState() {
    final DailyController dailyController =
        Provider.of<DailyController>(context, listen: false);
    if (dailyController.musimList.isNotEmpty) {
      musimId = dailyController.musimList.last.musimId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DailyController dailyController =
        Provider.of<DailyController>(context, listen: false);

    if (dailyController.musimList.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Text('Anda belum pernah memulai musim'),
        ),
      );
    }

    final stockRemaining = dailyController.getTotalStock(musimId);
    final period = dailyController.getPeriod(musimId);
    final totalDead = dailyController.getTotalDead(musimId);
    final totalSellings = dailyController.getTotalSellings(musimId);
    final totalObat = dailyController.getTotalObat(musimId);
    final totalPakan = dailyController.getTotalPakan(musimId);
    final totalSells = dailyController.getTotalSell(musimId);
    final profit = totalSellings - totalObat - totalPakan.toInt();

    String? selectedValue;
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Pilih Periode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: dailyController.musimList
                        .map((item) => DropdownMenuItem<String>(
                              value: item.musimId,
                              child: Text(
                                item.mulai,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        musimId = value!;
                      });
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black12,
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Keuntungan',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      AppFormat.currency(profit),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ProfitItem(
                    title: 'Terjual',
                    value: totalSells.toString(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ProfitItem(
                    value: totalDead.toString(),
                    title: 'Mati',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ProfitItem(
                    title: 'Sisa Stok',
                    value: stockRemaining.toString(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ProfitItem(
                    value: AppFormat.currency(totalObat),
                    title: 'Biaya Obat',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ProfitItem(
                    title: 'Biaya Pakan',
                    value: AppFormat.currency(
                      totalPakan.toInt(),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ProfitItem(
                    value: period,
                    title: 'Periode',
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
