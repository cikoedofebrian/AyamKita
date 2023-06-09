import 'package:app/constant/app_color.dart';
import 'package:app/controller/c_info_cuaca.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/weather_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MInfoCuacaHours extends StatelessWidget {
  const MInfoCuacaHours({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<CInfoCuaca>(context, listen: false).getInfoCuaca();
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                  top: 120, bottom: 20, left: 10, right: 10),
              itemCount: 8,
              itemBuilder: (context, index) => MInfoCuacaList(
                days: weatherData[index].getDays(),
                hour: weatherData[index].getDateTime(),
                icons: weatherData[index].getConditionIcon(),
                temp: weatherData[index].main,
              ),
            )),
        const CustomBackButton(
          color: AppColor.secondary,
        ),
      ],
    ));
  }
}
