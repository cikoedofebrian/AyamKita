import 'package:flutter/material.dart';

class DataListDetails extends StatelessWidget {
  const DataListDetails({super.key, required this.type, required this.number});
  final String type;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              type,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: Text(
                number,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
