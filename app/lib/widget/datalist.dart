import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/widget/datalistdetails.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  const DataList({
    super.key,
    required this.tanggal,
    required this.umur,
    required this.keluar,
    required this.pakan,
    required this.hargaObat,
    required this.hargaPakan,
    required this.kematian,
    required this.obat,
  });
  final DateTime tanggal;
  final int umur;
  final int keluar;
  final double pakan;
  final int hargaObat;
  final int hargaPakan;
  final int kematian;
  final String obat;
  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  bool isDown = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.5, color: AppColor.tertiary),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppFormat.dateFromDateTime(widget.tanggal),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isDown = !isDown;
                });
              },
              child: Icon(
                isDown
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 40,
              ),
            )
          ],
        ),
        if (isDown)
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              DataListDetails(
                  type: 'Umur Ayam', number: widget.umur.toString()),
              DataListDetails(
                  type: 'Kematian', number: widget.kematian.toString()),
              DataListDetails(
                  type: 'Obat',
                  number: widget.obat.isEmpty ? '-' : widget.obat),
              DataListDetails(type: 'Keluar', number: widget.keluar.toString()),
              DataListDetails(type: 'Pakan', number: widget.pakan.toString()),
              DataListDetails(
                  type: 'Harga Obat', number: widget.hargaObat.toString()),
              DataListDetails(
                  type: 'Harga Pakan', number: widget.hargaPakan.toString()),
            ],
          )
      ]),
    );
  }
}
