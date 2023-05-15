import 'package:app/constant/role.dart';
import 'package:app/controller/consultationcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/consultationwidget.dart';
import 'package:app/widget/customtop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultationList extends StatelessWidget {
  const ConsultationList({super.key});

  @override
  Widget build(BuildContext context) {
    final consultationController =
        Provider.of<ConsultationController>(context, listen: false);
    final userController = Provider.of<UserController>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const CustomTop(title: 'Konsultasi'),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    itemBuilder: (context, index) => ConsultationWidget(
                        data: consultationController.list[index],
                        isPemilik:
                            userController.user.role != UserRole.pemilik),
                    itemCount: consultationController.list.length,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
