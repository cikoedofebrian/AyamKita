import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/widget/datalistdetails.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  const DataList(
      {super.key,
      required this.tanggal,
      required this.umur,
      required this.datang,
      required this.pakai,
      required this.std,
      required this.stok,
      required this.kematian,
      required this.panen,
      required this.obat});
  final DateTime tanggal;
  final int umur;
  final int datang;
  final int pakai;
  final int std;
  final int stok;
  final int kematian;
  final int panen;
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
              DataListDetails(type: 'Panen', number: widget.panen.toString()),
              DataListDetails(
                  type: 'Obat',
                  number: widget.obat.isEmpty ? '-' : widget.obat),
              const Text(
                'Makanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DataListDetails(type: 'Datang', number: widget.datang.toString()),
              DataListDetails(type: 'Pakai', number: widget.pakai.toString()),
              DataListDetails(type: 'STD', number: widget.std.toString()),
              DataListDetails(type: 'Stok', number: widget.stok.toString()),
            ],
          )
      ]),
    );
  }
}
