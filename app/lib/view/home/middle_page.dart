import 'package:app/constant/role.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/view/farm/add_data.dart';
import 'package:app/view/features/profits/view_profit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiddlePage extends StatelessWidget {
  const MiddlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context, listen: false);
    if (cAuth.getDataProfile().role == UserRole.pemilik) {
      return const ViewProfit();
    }
    return const AddData();
  }
}
