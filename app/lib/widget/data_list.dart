import 'package:app/constant/app_color.dart';
import 'package:app/constant/app_format.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_jadwal_pakan.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/model/m_jadwal_pakan.dart';
import 'package:app/widget/data_list_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<bool>? feed;
  @override
  Widget build(BuildContext context) {
    if (Provider.of<CAuth>(context, listen: false).getDataProfile().role !=
        UserRole.dokter) {
      final feedController = Provider.of<CJadwalPakan>(context, listen: false);
      try {
        final MJadwalPakan data = feedController.getJadwalPakan().firstWhere(
              (element) => element.tanggal == widget.tanggal,
            );
        feed = [data.pagi, data.sore];
      } catch (err) {
        feed = [false, false];
      }
    }

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
              if (feed != null) ...[
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Presensi Pakan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pagi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: feed![0] ? Colors.green : Colors.grey,
                      size: 30,
                    )
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sore',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: feed![1] ? Colors.green : Colors.grey,
                      size: 30,
                    )
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
              ]
            ],
          )
      ]),
    );
  }
}
