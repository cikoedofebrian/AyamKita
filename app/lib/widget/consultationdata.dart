import 'package:flutter/material.dart';

class ConsultationDataWidget extends StatelessWidget {
  const ConsultationDataWidget(
      {super.key,
      required this.title,
      required this.data,
      required this.moreThanOneLine});

  final String title;
  final String data;
  final bool moreThanOneLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          key: ValueKey(title),
          initialValue: data,
          decoration: InputDecoration(
            contentPadding: moreThanOneLine
                ? const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
                : null,
            enabled: false,
          ),
          maxLines: moreThanOneLine ? 10 : 1,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
