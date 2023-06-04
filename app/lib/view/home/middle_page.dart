import 'package:app/constant/role.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/view/farm/add_data.dart';
import 'package:app/view/features/profits/view_profit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiddlePage extends StatelessWidget {
  const MiddlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController =
        Provider.of<UserController>(context, listen: false);
    if (userController.user.role == UserRole.pemilik) {
      return const ViewProfit();
    }
    return const AddData();
  }
}
