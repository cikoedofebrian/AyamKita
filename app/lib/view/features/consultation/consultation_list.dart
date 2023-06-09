import 'package:app/constant/app_color.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_konsultasi.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/widget/consultation_widget.dart';
import 'package:app/widget/custom_top.dart';
import 'package:app/widget/select_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultationList extends StatefulWidget {
  const ConsultationList({super.key});

  @override
  State<ConsultationList> createState() => _ConsultationListState();
}

class _ConsultationListState extends State<ConsultationList> {
  @override
  Widget build(BuildContext context) {
    final consultationController = Provider.of<CKonsultasi>(context);
    final cAuth = Provider.of<CAuth>(context, listen: false).getDataProfile();
    var list = consultationController.getDataUsulan();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const CustomTop(title: 'Konsultasi'),
                SelectStatus(
                  done: consultationController.isOnProgress,
                  changeStatus: consultationController.changesProgress,
                ),
                Expanded(
                  child: list.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 40),
                          itemBuilder: (context, index) => ConsultationWidget(
                            data: list[index],
                            isPemilik: cAuth.role != UserRole.pemilik,
                          ),
                          itemCount: list.length,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset(
                                  "assets/images/consultation_empty.png"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Konsultasi Kosong!',
                              style: TextStyle(color: AppColor.formborder),
                            )
                          ],
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
