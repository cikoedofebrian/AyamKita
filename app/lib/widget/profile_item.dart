import 'package:app/constant/app_color.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.assetName,
    required this.routeName,
    required this.title,
    this.size,
    this.function,
    this.argument,
  });
  final String routeName;
  final String title;
  final String assetName;
  final double? size;
  final Function? function;
  final dynamic argument;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (function != null) {
          function!();
        } else {
          Navigator.pushNamed(context, routeName, arguments: argument);
        }
      },
      child: SizedBox(
        height: 80,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color.fromRGBO(234, 92, 43, 0.1),
                ]),
            border: Border.all(
              width: 1,
              color: AppColor.tertiary,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  assetName,
                  scale: size ?? 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
