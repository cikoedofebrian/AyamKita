import 'package:flutter/material.dart';

class SelectStatus extends StatelessWidget {
  const SelectStatus(
      {super.key, required this.done, required this.changeStatus});

  final bool done;
  final Function(bool) changeStatus;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => changeStatus(true),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Berlangsung',
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 3,
                  color: done ? Colors.grey.shade400 : Colors.grey.shade200,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => changeStatus(false),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Selesai',
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 3,
                  color: !done ? Colors.grey.shade400 : Colors.grey.shade200,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
