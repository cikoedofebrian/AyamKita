import 'package:app/controller/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          print(Provider.of<UserController>(context, listen: false).farmId);
        },
        child: Material(
          elevation: 4,
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Usulkan Permintaan Konsultasi',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
