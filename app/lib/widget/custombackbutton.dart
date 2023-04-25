import 'package:app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        elevation: 4,
        child: CircleAvatar(
          radius: 27,
          backgroundColor: AppColor.tertiary,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.navigate_before_rounded,
                color: AppColor.tertiary,
              ),
              iconSize: 45,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    );
  }
}
