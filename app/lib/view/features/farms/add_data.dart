import 'package:app/constant/appcolor.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/customdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DateTime initialDate = DateTime.now();
  String umur = '';
  String pakai = '';
  String datang = '';
  String kematian = '';
  String std = '';
  String stok = '';
  String panen = '';
  String obat = '';
  bool editable = true;
  final formKey = GlobalKey<FormState>();

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await Provider.of<DailyController>(context, listen: false)
          .addData(
        initialDate,
        int.parse(datang),
        int.parse(umur),
        int.parse(pakai),
        int.parse(std),
        int.parse(stok),
        int.parse(kematian),
        int.parse(panen),
        obat,
        Provider.of<UserController>(context, listen: false).farmId,
      )
          .then((value) {
        customDialog(context, 'Berhasil!', 'Data berhasil ditambahkan!');
      });
    } else {
      NDialog(
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Simpan data gagal!',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Tutup'))
        ],
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dailyController = Provider.of<DailyController>(context);

    return Theme(
      data: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            outlineBorder: BorderSide(color: Colors.grey),
            disabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            filled: true,
            fillColor: AppColor.formcolor),
      ),
      child: FutureBuilder(
          future: dailyController.checkDate(initialDate),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              editable = false;
              umur = snapshot.data!.umur.toString();
              pakai = snapshot.data!.pakai.toString();
              datang = snapshot.data!.datang.toString();
              kematian = snapshot.data!.kematian.toString();
              std = snapshot.data!.std.toString();
              stok = snapshot.data!.stok.toString();
              panen = snapshot.data!.panen.toString();
              obat = snapshot.data!.obat;
            } else {
              umur = '';
              pakai = '';
              datang = '';
              kematian = '';
              std = '';
              stok = '';
              panen = '';
              obat = '';
              editable = true;
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tambah Data Harian'),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(
                                initialDate,
                              ),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (!editable)
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColor.secondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'DATA SUDAH ADA',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              'Anda tidak bisa merubah data yang sudah ada',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Tanggal'),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('dd-MM-yyyy', 'id_ID')
                                      .format(initialDate),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  height: 40,
                                  child: InkWell(
                                    child:
                                        Image.asset('assets/images/daily.png'),
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: initialDate,
                                              firstDate: DateTime.now()
                                                  .subtract(
                                                      const Duration(days: 7)),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            initialDate = value;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Umur Ayam'),
                            const SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              key: UniqueKey(),
                              initialValue: umur,
                              enabled: editable,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Wajib diisi";
                                } else if (int.tryParse(value) == null) {
                                  return "Isi dengan angka";
                                }
                                return null;
                              },
                              onSaved: (newValue) => umur = newValue!,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Makanan'),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  color: AppColor.formcolor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Datang'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            TextFormField(
                                              initialValue: datang,
                                              key: UniqueKey(),
                                              enabled: editable,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return "Isi dengan angka";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) =>
                                                  datang = newValue!,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
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
                                            const Text('Pakai'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            TextFormField(
                                              initialValue: pakai,
                                              key: UniqueKey(),
                                              enabled: editable,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return "Isi dengan angka";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) =>
                                                  pakai = newValue!,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('STD'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            TextFormField(
                                              initialValue: std,
                                              key: UniqueKey(),
                                              enabled: editable,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return "Isi dengan angka";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) =>
                                                  std = newValue!,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
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
                                            const Text('Stok'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            TextFormField(
                                              initialValue: stok,
                                              key: UniqueKey(),
                                              enabled: editable,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return "Isi dengan angka";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) =>
                                                  stok = newValue!,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Kematian (Ekor)'),
                            const SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              initialValue: kematian,
                              key: UniqueKey(),
                              enabled: editable,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Wajib diisi";
                                } else if (int.tryParse(value) == null) {
                                  return "Isi dengan angka";
                                }
                                return null;
                              },
                              onSaved: (newValue) => kematian = newValue!,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Panen (Ekor/kg)'),
                            const SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              key: UniqueKey(),
                              initialValue: panen,
                              enabled: editable,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Wajib diisi";
                                } else if (int.tryParse(value) == null) {
                                  return "Isi dengan angka";
                                }
                                return null;
                              },
                              onSaved: (newValue) => panen = newValue!,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Obat'),
                            const SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              key: UniqueKey(),
                              initialValue: obat,
                              enabled: editable,
                              onSaved: (newValue) => obat = newValue!,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => editable ? save(context) : null,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: editable ? AppColor.tertiary : Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 25),
                            child: Text(
                              'SIMPAN',
                              style: TextStyle(
                                color: editable
                                    ? AppColor.secondary
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
