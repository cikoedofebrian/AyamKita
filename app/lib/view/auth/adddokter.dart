import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/model/workinghours.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDokter extends StatefulWidget {
  const AddDokter({super.key});

  @override
  State<AddDokter> createState() => _AddDokterState();
}

class _AddDokterState extends State<AddDokter> {
  final formKey = GlobalKey<FormState>();
  String deskripsi = '';
  String price = '';
  final hour1Controller = TextEditingController();
  final hour2Controller = TextEditingController();
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

  List<WorkingHours> hoursList = [];

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
    });
  }

  bool checkIfAdded(int index) {
    int result = hoursList.indexWhere((element) => element.day == index);
    if (result != -1) {
      return true;
    } else {
      return false;
    }
  }

  int currentIndex = 0;
  List<Widget> hourList = [];
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
    final isAdded = checkIfAdded(currentIndex);
    final Function(String, String) completeRegistration =
        ModalRoute.of(context)!.settings.arguments as Function(String, String);
    hour1Controller.text = AppFormat.dayTimeToString(hour1);
    hour2Controller.text = AppFormat.dayTimeToString(hour2);

    void trySignUp() async {
      formKey.currentState!.save();
      {
        if (deskripsi.isEmpty || hoursList.isEmpty || price.isEmpty) {
          customDialog(
            context,
            'Gagal',
            'Data tidak boleh kosong!',
          );
          return;
        } else if (deskripsi.length < 50) {
          customDialog(context, 'Gagal', 'Deskripsi minimal 50 karakter!');
          return;
        } else if (int.tryParse(price) == null) {
          customDialog(context, 'Gagal', 'Berikan harga yang valid!');
        }
        final result = await Provider.of<UserController>(context, listen: false)
            .addDokterData(deskripsi, int.parse(price));
        final complete = await completeRegistration(result, UserRole.dokter)
            .then((value) => Provider.of<UserController>(context, listen: false)
                .addJamKerja(value, hoursList)
                .then((value) => customDialog(
                        context, 'Berhasil', 'Pendaftaran Akun Berhasil!')
                    .then((value) =>
                        Navigator.pushReplacementNamed(context, '/home'))));
      }
    }

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
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
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 160,
                                ),
                                Positioned(
                                  width: 260,
                                  top: 10,
                                  child: TextFormField(
                                    maxLines: 5,
                                    onSaved: (newValue) =>
                                        deskripsi = newValue!,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                    ),
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
                                      'Deskripsi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 70,
                                  ),
                                  Positioned(
                                    width: 260,
                                    top: 10,
                                    child: TextFormField(
                                      onSaved: (newValue) => price = newValue!,
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
                                        'Harga Konsultasi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                                MainAxisAlignment.spaceBetween,
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
                            ...hourList,
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => isAdded
                                  ? null
                                  : addNewHour(currentIndex, hour1, hour2),
                              child: Container(
                                width: 260,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      isAdded ? Colors.grey : AppColor.tertiary,
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
                              onTap: () => trySignUp(),
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
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        const CustomBackButton(color: AppColor.secondary),
      ]),
    );
  }
}
