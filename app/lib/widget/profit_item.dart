import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:flutter/material.dart';

class ProfitItem extends StatelessWidget {
  const ProfitItem({
    super.key,
    required this.value,
    required this.title,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: AppColor.tertiary),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.black12,
                spreadRadius: 2,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            FittedBox(
              child: Text(
                value,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
