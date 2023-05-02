import 'package:app/constant/appcolor.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:flutter/material.dart';

class ChangeSkema extends StatefulWidget {
  const ChangeSkema({super.key});

  @override
  State<ChangeSkema> createState() => _ChangeSkemaState();
}

class _ChangeSkemaState extends State<ChangeSkema> {
  final hour1Controller = TextEditingController();
  final hour2Controller = TextEditingController();
  TimeOfDay hour1 = TimeOfDay.now();
  TimeOfDay hour2 = TimeOfDay.now();
  @override
  void initState() {
    hour1Controller.text = hour1Controller.text =
        "${hour1.hour.toString().padLeft(2, '0')}:${hour1.minute.toString().padLeft(2, '0')}";
    hour2Controller.text =
        "${hour2.hour.toString().padLeft(2, '0')}:${hour2.minute.toString().padLeft(2, '0')}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void tryChange() {
      customDialog(
              context, 'Berhasil', 'Jadwal baru akan mulai diberlakukan besok')
          .then((value) => Navigator.of(context).pop());
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
                  'GANTI JADWAL PAKAN',
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
                        child: Column(
                          children: [
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
                                          enabled: false,
                                          controller: hour1Controller,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                          ),
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
                                          enabled: false,
                                          controller: hour2Controller,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15),
                                          ),
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
                              height: 10,
                            ),
                            InkWell(
                              onTap: tryChange,
                              child: Container(
                                width: 260,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.secondary,
                                ),
                                child: const Text(
                                  'GANTI',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ],
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
