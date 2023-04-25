import 'package:app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class RequestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.secondary
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(size.width, size.height - 20);
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width * 0.5, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height, 0, size.height - 20);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawShadow(path, Colors.black, 15, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
