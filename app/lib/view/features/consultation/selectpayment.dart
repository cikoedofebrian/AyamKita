import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/consultationcontroller.dart';
import 'package:app/controller/consultationrequest.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/customdialog.dart';
import 'package:app/widget/customtop.dart';
import 'package:app/widget/paymentwidget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

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
    final findDocController =
        Provider.of<FindDoctorController>(context, listen: false);
    final consultationController = Provider.of<ConsultationController>(context);

    void tryPay() {
      if (_selectedPayment.isEmpty) {
        customDialog(context, 'Gagal', 'Tolong Pilih Pembayaran!');
        return;
      }
      consultationController.createNewConsultation(
          _selectedPayment,
          Provider.of<UserController>(context, listen: false).user.peternakanId,
          findDocController.selectedModel!.dokterId,
          Provider.of<ConsultationRequestController>(context, listen: false)
              .isSelected,
          findDocController.selectedModel!.harga);
      Navigator.pushReplacementNamed(context, '/payment-success');
    }

    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: consultationController.isLoading
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: AppColor.secondary, size: 60),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Expanded(
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
                                      isSelected: _selectedPayment == e.key
                                          ? true
                                          : false,
                                      type: e.key,
                                      func: selectPayment,
                                    ))
                                .toList()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Biaya :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    AppFormat.currency(
                                        findDocController.selectedModel!.harga),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: tryPay,
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColor.tertiary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    'SELESAIKAN PEMBAYARAN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
        const CustomTop(title: 'Pembayaran')
      ],
    ));
  }
}
