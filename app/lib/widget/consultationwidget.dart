import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/consultationcontroller.dart';
import 'package:app/model/consultationmodel.dart';
import 'package:app/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ConsultationWidget extends StatelessWidget {
  const ConsultationWidget({super.key, required this.data});

  final ConsultationModel data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [data.getFarmData(), data.getData(UserRole.dokter)],
      ),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? LoadingAnimationWidget.inkDrop(color: AppColor.tertiary, size: 20)
          : InkWell(
              onTap: () {
                Provider.of<ConsultationController>(context, listen: false)
                    .setSelectedChat(data.konsultasiId);
                Navigator.of(context).pushNamed('/consultation-view',
                    arguments: [snapshot.data![0], snapshot.data![1]]);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(color: AppColor.secondary),
                child: Row(
                  children: [Text((snapshot.data![1] as UserModel).nama)],
                ),
              ),
            ),
    );
  }
}
