import 'package:app/constant/app_color.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget(
      {super.key,
      required this.image,
      required this.isSelected,
      required this.type,
      required this.func});
  final String type;
  final String image;
  final bool isSelected;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(type),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: AppColor.formborder,
          ),
        ),
        child: Row(children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  child: Image.asset(image),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  type,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: AppColor.formborder),
            ),
            child: CircleAvatar(
              backgroundColor:
                  isSelected ? AppColor.formborder : Colors.transparent,
              radius: 10,
            ),
          )
          // CircleAvatar(
          //   radius: 20,
          //   backgroundColor: Colors.green,
          // ),
        ]),
      ),
    );
  }
}
