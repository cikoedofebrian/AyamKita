import 'package:app/constant/appcolor.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/widget/customtop.dart';
import 'package:app/widget/dokter_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FindDoctor extends StatefulWidget {
  const FindDoctor({super.key});

  @override
  State<FindDoctor> createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final findDoctorController = Provider.of<FindDoctorController>(context);
    if (findDoctorController.isLoading == true) {
      findDoctorController.fetchData();
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: findDoctorController.isLoading
                ? Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: AppColor.secondary, size: 60),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 160,
                      left: 40,
                      right: 40,
                    ),
                    itemBuilder: (context, index) => DokterListWidget(
                        data: findDoctorController.list[index]),
                    itemCount: findDoctorController.list.length,
                  ),
          ),
          const CustomTop(title: 'Cari Dokter'),
        ],
      ),
    );
  }
}
