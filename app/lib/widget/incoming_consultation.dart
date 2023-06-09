import 'package:app/controller/c_konsultasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomingSchedule extends StatelessWidget {
  const IncomingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage("assets/images/weatherbackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Column(
              children: [
                const Text(
                  'Usulan yang sedang berlangsung : ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    Provider.of<CKonsultasi>(context).list.length.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12)),
              child: const Text(
                'Lihat Semua Konsultasi',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
