import 'package:app/constant/appcolor.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/requestpainter.dart';
import 'package:flutter/material.dart';

class CustomTop extends StatelessWidget {
  const CustomTop({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
