import 'package:app/constant/app_color.dart';
import 'package:app/constant/app_format.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_peternakan.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFarm extends StatefulWidget {
  const AddFarm({super.key});

  @override
  State<AddFarm> createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  final formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  final dateController = TextEditingController();
  final hour1Controller = TextEditingController();
  final hour2Controller = TextEditingController();
  String nama = '';
  String luas = '';
  String alamat = '';
  TimeOfDay hour1 = TimeOfDay.now();
  TimeOfDay hour2 = TimeOfDay.now();

  @override
  void initState() {
    dateController.text = AppFormat.dateFromDateTime(currentDate);
    hour1Controller.text = hour1Controller.text =
        "${hour1.hour.toString().padLeft(2, '0')}:${hour1.minute.toString().padLeft(2, '0')}";
    hour2Controller.text =
        "${hour2.hour.toString().padLeft(2, '0')}:${hour2.minute.toString().padLeft(2, '0')}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<void> Function(String, String) completeRegistration =
        ModalRoute.of(context)!.settings.arguments as Future<void> Function(
            String, String);

    void trySignUp() async {
      formKey.currentState!.save();
      if (nama.isEmpty || alamat.isEmpty || luas.isEmpty) {
        customDialog(context, 'Gagal', 'Data tidak boleh ada yang kosong!');
        return;
      } else if (int.tryParse(luas) == null) {
        customDialog(context, 'Gagal', 'Luas harus berwujud angka');
      } else {
        try {
          final upload = await Provider.of<CPeternakan>(context, listen: false)
              .simpanRegisterPeternakan(
                  nama,
                  alamat,
                  int.parse(luas),
                  AppFormat.intDateFromDateTime(currentDate),
                  "${hour1.hour.toString().padLeft(2, '0')}:${hour1.minute.toString().padLeft(2, '0')}",
                  "${hour2.hour.toString().padLeft(2, '0')}:${hour2.minute.toString().padLeft(2, '0')}");
          await completeRegistration(upload, UserRole.pemilik).then((value) =>
              customDialog(context, 'Berhasil', 'Akun berhasil dibuat!').then(
                  (value) => Navigator.pushReplacementNamed(context, '/home')));
        } on FirebaseException catch (error) {
          customDialog(context, 'Gagal', error.message!);
        }
      }
    }

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
                  'DATA PETERNAKAN BARU',
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
                                      onSaved: (newValue) => nama = newValue!,
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
                                        'Nama Peternakan',
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
                                      onSaved: (newValue) => alamat = newValue!,
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
                                        'Alamat',
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
                                      onSaved: (newValue) => luas = newValue!,
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
                                        'Luas',
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
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: dateController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15)),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 5),
                                          height: 35,
                                          child: InkWell(
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: currentDate,
                                                firstDate: DateTime(
                                                    DateTime.now().year - 100),
                                                lastDate: DateTime.now(),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    currentDate = value;
                                                    dateController.text =
                                                        AppFormat
                                                            .dateFromDateTime(
                                                                value);
                                                  });
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                                'assets/images/daily.png',
                                                fit: BoxFit.fitHeight),
                                          ),
                                        ),
                                      ],
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
                                        'Beroperasi semenjak',
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
                              const Text(
                                'Jadwal Pakan',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                  ),
                                  Positioned(
                                    width: 260,
                                    top: 10,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: hour1Controller,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15)),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 5),
                                          height: 35,
                                          child: InkWell(
                                            onTap: () {
                                              showTimePicker(
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                true),
                                                    child: child!,
                                                  );
                                                },
                                                context: context,
                                                initialTime: TimeOfDay(
                                                  hour: DateTime.now().hour,
                                                  minute: DateTime.now().minute,
                                                ),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    hour1 = value;
                                                    hour1Controller.text =
                                                        "${hour1.hour.toString().padLeft(2, '0')}:${hour1.minute.toString().padLeft(2, '0')}";
                                                  });
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                                'assets/images/daily.png',
                                                fit: BoxFit.fitHeight),
                                          ),
                                        ),
                                      ],
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
                                        'Pagi',
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
                                height: 10,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                  ),
                                  Positioned(
                                    width: 260,
                                    top: 10,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: hour2Controller,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15)),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 5),
                                          height: 35,
                                          child: InkWell(
                                            onTap: () {
                                              showTimePicker(
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                true),
                                                    child: child!,
                                                  );
                                                },
                                                context: context,
                                                initialTime: TimeOfDay(
                                                  hour: DateTime.now().hour,
                                                  minute: DateTime.now().minute,
                                                ),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    hour2 = value;
                                                    hour2Controller.text =
                                                        "${hour2.hour.toString().padLeft(2, '0')}:${hour1.minute.toString().padLeft(2, '0')}";
                                                  });
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                                'assets/images/daily.png',
                                                fit: BoxFit.fitHeight),
                                          ),
                                        ),
                                      ],
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
                                        'Sore',
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
                                onTap: trySignUp,
                                child: Container(
                                  width: 260,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.secondary,
                                  ),
                                  child: const Text(
                                    'DAFTAR',
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
