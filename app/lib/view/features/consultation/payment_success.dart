import 'package:app/constant/app_color.dart';
import 'package:app/controller/c_usulan_konsultasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pembayaran Berhasil!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Masuk ke menu konsultasi untuk melanjutkan proses konsultasi!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<CUsulanKonsultasi>(context, listen: false)
                    .selectRequest("");
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.tertiary,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'KEMBALI KE HALAMAN UTAMA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
