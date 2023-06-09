import 'package:app/constant/app_color.dart';
import 'package:app/constant/app_format.dart';
import 'package:app/controller/c_harga_pasar.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/request_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceList extends StatelessWidget {
  const PriceList({super.key});

  @override
  Widget build(BuildContext context) {
    final priceController =
        Provider.of<CHargaPasar>(context, listen: false).list.reversed.toList();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 160, left: 40, right: 40, bottom: 20),
                    itemCount: priceController.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              AppFormat.dateFromDateTime(
                                  priceController[index].date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                AppFormat.currency(
                                    priceController[index].price),
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    140,
                  ),
                  painter: RequestPainter(),
                ),
                const CustomBackButton(
                  color: AppColor.quaternary,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 14),
                    child: Text(
                      'Histori Harga Ayam',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CustomBackButton(color: AppColor.secondary),
        ],
      ),
    );
  }
}
