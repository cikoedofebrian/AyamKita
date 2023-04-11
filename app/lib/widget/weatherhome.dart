import 'dart:ui';

import 'package:app/controller/weathercontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    final weathercontroller = Provider.of<WeatherController>(context);
    return Container(
      height: 180,
      // width: double.infinity,
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
                              weathercontroller.list[index + 1]
                                  .getConditionIcon(),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${weathercontroller.list[index + 1].getDateTime()} - ${weathercontroller.list[index + 1].getConditionName()}",
                              // 'Hari ini - Berawan',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Icon(
                      //       Icons.cloud,
                      //       color: Colors.white,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       weathercontroller.list[0].weather.toString(),
                      //       // 'Hari ini - Berawan',
                      //       style: TextStyle(color: Colors.white),
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   children: const [
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Icon(
                      //       Icons.cloud,
                      //       color: Colors.white,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       'Hari ini - Berawan',
                      //       style: TextStyle(color: Colors.white),
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   children: const [
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Icon(
                      //       Icons.cloud,
                      //       color: Colors.white,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       'Hari ini - Berawan',
                      //       style: TextStyle(color: Colors.white),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      weathercontroller.list[0].getConditionIcon(),
                      size: 80,
                      color: Colors.white,
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Text(
                      "${weathercontroller.list[0].main.round()}° C - ${weathercontroller.list[0].getConditionName()}",
                      // '28° - Berawan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, '/weather-list'),
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
