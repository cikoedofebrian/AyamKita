import 'package:app/controller/c_info_cuaca.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MInfoCuacaHome extends StatelessWidget {
  const MInfoCuacaHome({super.key});

  @override
  Widget build(BuildContext context) {
    final weathercontroller = Provider.of<CInfoCuaca>(context);
    final weatherData = weathercontroller.getInfoCuaca();
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage("assets/images/weatherbackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        weathercontroller.cityName,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      ...List.generate(
                        3,
                        (index) => Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              weatherData[index + 1].getConditionIcon(),
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${weatherData[index + 1].getDateTime()} - ${weatherData[index + 1].getConditionName()}",
                              // 'Hari ini - Berawan',
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      weatherData[0].getConditionIcon(),
                      size: 80,
                      color: Colors.white,
                    ),
                    Text(
                      "${weatherData[0].main.round()}° C - ${weatherData[0].getConditionName()}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, '/weather-hours'),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white24, borderRadius: BorderRadius.circular(12)),
            child: const Text(
              'Ramalan 24 Jam',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}
