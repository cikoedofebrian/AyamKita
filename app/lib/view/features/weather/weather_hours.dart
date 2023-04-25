import 'package:app/controller/weathercontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/weatherlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherHours extends StatelessWidget {
  const WeatherHours({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<WeatherController>(context, listen: false).list;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 120, bottom: 20),
              itemCount: 8,
              itemBuilder: (context, index) => WeatherList(
                  days: weatherData[index].getDays(),
                  hour: weatherData[index].getDateTime(),
                  icons: weatherData[index].getConditionIcon(),
                  temp: weatherData[index].main),
            )),
        const CustomBackButton(),
      ],
    ));
  }
}
