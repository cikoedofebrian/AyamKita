import 'package:app/constant/appcolor.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMusim extends StatefulWidget {
  const AddMusim({super.key});

  @override
  State<AddMusim> createState() => _AddMusimState();
}

class _AddMusimState extends State<AddMusim> {
  final formKey = GlobalKey<FormState>();
  String tipe = '';
  int harga = 0;
  int jumlah = 0;

  void tryDaftarMusim() async {
    formKey.currentState!.save();
    if (harga <= 0 || jumlah <= 0 || tipe.isEmpty) {
      customDialog(context, 'Gagal', 'Data tidak boleh kosong!');
    } else {
      await Provider.of<DailyController>(context, listen: false)
          .addMusim(
              tipe,
              jumlah,
              harga,
              Provider.of<UserController>(context, listen: false)
                  .user
                  .peternakanId)
          .then(
            (value) =>
                customDialog(context, 'Berhasil', 'Musim berhasil dibuat!')
                    .then((value) => Navigator.of(context).pop()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            const CustomBackButton(color: AppColor.secondary),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BUAT MUSIM BARU',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                  ),
                                  Positioned(
                                    width: 260,
                                    top: 10,
                                    child: TextFormField(
                                      onSaved: (newValue) => tipe = newValue!,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: const Text(
                                        'Tipe Ayam',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                  ),
                                  Positioned(
                                    width: 260,
                                    top: 10,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onSaved: (newValue) {
                                        if (int.tryParse(newValue!) != null) {
                                          jumlah = int.parse(newValue);
                                        } else {
                                          jumlah = 0;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: const Text(
                                        'Jumlah',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                  ),
                                  Positioned(
                                    width: 260,
                                    top: 10,
                                    child: TextFormField(
                                      onSaved: (newValue) {
                                        if (int.tryParse(newValue!) != null) {
                                          harga = int.parse(newValue);
                                        } else {
                                          harga = 0;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: const Text(
                                        'Harga Per Ayam',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: tryDaftarMusim,
                                child: Container(
                                  width: 260,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.secondary,
                                  ),
                                  child: const Text(
                                    'BUAT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
