import 'package:app/constant/appcolor.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/navbarbgpainter.dart';
import 'package:app/widget/requestpainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: Stack(children: [
                CustomPaint(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    140,
                  ),
                  painter: RequestPainter(),
                ),
                CustomBackButton(
                  color: AppColor.quaternary,
                ),
                const Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      'Usulan Konsultasi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
