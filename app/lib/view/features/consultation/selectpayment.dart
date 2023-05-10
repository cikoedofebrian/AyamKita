import 'package:app/widget/customtop.dart';
import 'package:app/widget/paymentwidget.dart';
import 'package:flutter/material.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({super.key});

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  final Map<String, String> paymentMethod = {
    'DANA': 'assets/images/dana.png',
    'SHOPEEPAY': 'assets/images/shopee.png',
    'GOPAY': 'assets/images/gopay.png',
    'OVO': 'assets/images/ovo.png',
  };

  String _selectedPayment = '';

  void selectPayment(String type) {
    setState(() {
      _selectedPayment = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 160,
                ),
                const Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ...paymentMethod.entries
                    .map((e) => PaymentWidget(
                          image: e.value,
                          isSelected: _selectedPayment == e.key ? true : false,
                          type: e.key,
                          func: selectPayment,
                        ))
                    .toList()
              ],
            ),
          ),
        ),
        const CustomTop(title: 'Pembayaran')
      ],
    ));
  }
}
