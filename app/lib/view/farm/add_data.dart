import 'package:app/constant/app_color.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_harga_pasar.dart';
import 'package:app/controller/c_data_harian.dart';
import 'package:app/controller/c_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DateTime initialDate = DateTime.now();
  String umur = '';
  String pakan = '';
  String hargaPakan = '';
  String kematian = '';
  String keluar = '';
  String obat = '';
  String hargaObat = '';
  bool editable = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context, listen: false).getDataProfile();
    final dailyController = Provider.of<CDataHarian>(context);
    final chickenPriceController =
        Provider.of<CHargaPasar>(context, listen: false);
    final index = dailyController.indexActive();
    void save() async {
      final isConfirmed = await dailyController.validasiForm(
          context, index, initialDate, formKey);
      if (isConfirmed) {
        final selectedPrice = chickenPriceController.list.firstWhere(
          (element) =>
              element.date ==
              DateTime(
                initialDate.year,
                initialDate.month,
                initialDate.day,
              ),
        );
        // ignore: use_build_context_synchronously
        dailyController.updateDataHarian(
          initialDate,
          int.parse(umur),
          double.parse(pakan),
          int.parse(hargaPakan),
          int.parse(kematian),
          int.parse(keluar),
          int.parse(hargaObat),
          obat,
          index,
          selectedPrice.price,
          context,
        );
      }
    }

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
          future: index >= 0
              ? dailyController.getTambahData(initialDate, index)
              : null,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              umur = snapshot.data!.umur.toString();
              pakan = snapshot.data!.pakan.toString();
              hargaPakan = snapshot.data!.hargaPakan.toString();
              kematian = snapshot.data!.kematian.toString();
              keluar = snapshot.data!.keluar.toString();
              obat = snapshot.data!.obat.toString();
              hargaObat = snapshot.data!.hargaObat.toString();
              editable = false;
            } else {
              umur = '';
              pakan = '';
              hargaPakan = '';
              kematian = '';
              keluar = '';
              obat = '';
              hargaObat = '';
              if (cAuth.role == UserRole.pengelola) {
                editable = true;
              } else {
                editable = false;
              }
            }
            if (index == -1) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'TIDAK ADA MUSIM YANG AKTIF',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (cAuth.role == UserRole.pemilik)
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, '/add-musim'),
                          child: SizedBox(
                            child: Material(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.secondary,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                child: Text(
                                  'Tambah Musim',
                                  style: TextStyle(
                                      color: AppColor.tertiary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }
            final parsedDate = DateFormat('dd-MM-yyyy')
                .parse(dailyController.musimList[index].mulai);
            return SingleChildScrollView(
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColor.blue,
                                  AppColor.tertiary,
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    spreadRadius: 2)
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Periode',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                      .format(initialDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (!editable && cAuth.role == UserRole.pengelola)
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColor.secondary,
                                    Colors.red,
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      spreadRadius: 2)
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                          Text(
                                            'Anda tidak bisa merubah data yang sudah ada',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ]),
                                  ),
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
                                DateFormat('dd-MM-yyyy').format(initialDate),
                                style: const TextStyle(fontSize: 18),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 40,
                                child: InkWell(
                                  child: Image.asset('assets/images/daily.png'),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: parsedDate,
                                      lastDate: DateTime(
                                          parsedDate.year,
                                          parsedDate.month,
                                          parsedDate.day + 40),
                                    ).then((value) {
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
                          const Text('Keluar'),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            key: UniqueKey(),
                            initialValue: keluar,
                            enabled: editable,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Wajib diisi";
                              } else if (int.tryParse(value) == null) {
                                return "Isi dengan angka";
                              }
                              return null;
                            },
                            onSaved: (newValue) => keluar = newValue!,
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Pakan (kg)'),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            key: UniqueKey(),
                            initialValue: pakan,
                            enabled: editable,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Wajib diisi";
                              } else if (double.tryParse(value) == null) {
                                return "Isi dengan angka";
                              }
                              return null;
                            },
                            onSaved: (newValue) => pakan = newValue!,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Harga Pakan'),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            key: UniqueKey(),
                            initialValue: hargaPakan,
                            enabled: editable,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Wajib diisi";
                              } else if (int.tryParse(value) == null) {
                                return "Isi dengan angka";
                              }
                              return null;
                            },
                            onSaved: (newValue) => hargaPakan = newValue!,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Harga Obat'),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            key: UniqueKey(),
                            initialValue: hargaObat,
                            enabled: editable,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Wajib diisi";
                              } else if (int.tryParse(value) == null) {
                                return "Isi dengan angka";
                              }
                              return null;
                            },
                            onSaved: (newValue) => hargaObat = newValue!,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (cAuth.role == UserRole.pengelola)
                      InkWell(
                        onTap: () => editable ? save() : null,
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
            );
          }),
    );
  }
}
