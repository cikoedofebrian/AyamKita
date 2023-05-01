import 'package:app/constant/appcolor.dart';
import 'package:app/widget/datalistdetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({
    super.key,
    required this.tipe,
    required this.jumlah,
    required this.tanggal,
    required this.index,
  });

  final String tanggal;
  final String tipe;
  final String jumlah;
  final int index;

  @override
  State<SessionWidget> createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/data-history',
          arguments: widget.index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColor.blue,
              AppColor.tertiary,
            ],
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Periode',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isDown = !isDown;
                    });
                  },
                  icon: Icon(
                    isDown
                        ? Icons.arrow_drop_up_rounded
                        : Icons.arrow_drop_down_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                  .format(DateFormat('dd-MM-yyyy').parse(widget.tanggal)),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            if (isDown) ...[
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tipe',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.tipe,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jumlah',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.jumlah,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
