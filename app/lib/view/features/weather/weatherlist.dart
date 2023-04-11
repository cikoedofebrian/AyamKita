import 'package:flutter/material.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text('close')));
  }
}
