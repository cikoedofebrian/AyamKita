import 'package:app/controller/consultationcontroller.dart';
import 'package:app/widget/consultationwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultationList extends StatelessWidget {
  const ConsultationList({super.key});

  @override
  Widget build(BuildContext context) {
    final consultationController =
        Provider.of<ConsultationController>(context, listen: false);
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemBuilder: (context, index) =>
                ConsultationWidget(data: consultationController.list[index]),
            itemCount: consultationController.list.length,
          ),
        )
      ],
    ));
  }
}
