import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/controller/workinghourscontroller.dart';
import 'package:app/model/workinghours.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeWorkHours extends StatefulWidget {
  const ChangeWorkHours({super.key});

  @override
  State<ChangeWorkHours> createState() => _ChangeWorkHoursState();
}

class _ChangeWorkHoursState extends State<ChangeWorkHours> {
  final formKey = GlobalKey<FormState>();
  String deskripsi = '';
  final hour1Controller = TextEditingController();
  final hour2Controller = TextEditingController();
  late List<WorkingHours> hoursList;
  TimeOfDay hour1 = TimeOfDay.now();
  TimeOfDay hour2 = TimeOfDay.now();

  List<String> week = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  @override
  void initState() {
    hoursList = List<WorkingHours>.from(
        Provider.of<WorkingHoursControllers>(context, listen: false).list);
    super.initState();
  }

  // List<WorkingHours> hoursList = [];

  void addNewHour(int index, TimeOfDay start, TimeOfDay end) {
    setState(() {
      hoursList.add(
        WorkingHours(
          jamKerjaId: null,
          dokterId: null,
          mulai: hour1,
          berakhir: end,
          day: index,
        ),
      );
      hoursList.sort(
        (a, b) => (a.day).compareTo(b.day),
      );
    });
  }

  int currentIndex = 0;
  ListView getHourWidget() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: week.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => changeCurrentIndex(index),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: index == currentIndex ? AppColor.secondary : Colors.grey,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            week[index],
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void changeCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool checkIfAdded(int index) {
      int result = hoursList.indexWhere((element) => element.day == index);
      if (result != -1) {
        return true;
      } else {
        return false;
      }
    }

    final isAdded = checkIfAdded(currentIndex);
    hour1Controller.text = AppFormat.dayTimeToString(hour1);
    hour2Controller.text = AppFormat.dayTimeToString(hour2);

    void tryChange() async {
      if (hoursList.isEmpty) {
        customDialog(context, 'Gagal', 'Data tidak boleh kosong!');
        return;
      }
      await Provider.of<WorkingHoursControllers>(context, listen: false)
          .updateData(hoursList)
          .then((value) {
        customDialog(context, 'Berhasil', 'Data berhasil diubah!')
            .then((value) => Navigator.pop(context));
      });
    }

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DATA DOKTER BARU',
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
                              const Text(
                                'Jam Kerja',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ...hoursList
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 5,
                                            backgroundColor: Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(week[e.day]),
                                                Text(
                                                    "${AppFormat.dayTimeToString(e.mulai)}- ${AppFormat.dayTimeToString(e.berakhir)}"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                hoursList.remove(e);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 35,
                                child: getHourWidget(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Mulai'),
                                          InkWell(
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime: hour1)
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    hour1 = value;
                                                  });
                                                }
                                              });
                                            },
                                            child: TextField(
                                              enabled: false,
                                              controller: hour1Controller,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Berakhir'),
                                          InkWell(
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime: hour2)
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    hour2 = value;
                                                  });
                                                }
                                              });
                                            },
                                            child: TextField(
                                              enabled: false,
                                              controller: hour2Controller,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                // onTap: () => print(
                                //     FirebaseAuth.instance.currentUser!.uid),
                                onTap: () => !isAdded
                                    ? addNewHour(currentIndex, hour1, hour2)
                                    : null,
                                child: Container(
                                  width: 260,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: isAdded
                                        ? Colors.grey
                                        : AppColor.tertiary,
                                  ),
                                  child: const Text(
                                    'TAMBAH',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () => tryChange(),
                                // onTap: () => trySignUp(),
                                child: Container(
                                  width: 260,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.secondary,
                                  ),
                                  child: const Text(
                                    'SIMPAN',
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
          ),
        ),
        const CustomBackButton(color: AppColor.secondary),
      ]),
    );
  }
}
