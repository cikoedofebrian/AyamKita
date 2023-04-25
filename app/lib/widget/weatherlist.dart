import 'package:app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class WeatherList extends StatelessWidget {
  const WeatherList(
      {super.key,
      required this.temp,
      required this.days,
      required this.hour,
      required this.icons});

  final double temp;
  final String days;
  final String hour;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
        border: Border.all(
          width: 1.5,
          color: AppColor.tertiary,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hour,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              days,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              temp.toStringAsFixed(0),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 46),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 2),
              child: Row(children: const [
                Text('°'),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'C',
                  style: TextStyle(fontSize: 22),
                )
              ]),
            ),
          ],
        ),
        Icon(
          icons,
          size: 65,
        )
      ]),
    );
  }
}
