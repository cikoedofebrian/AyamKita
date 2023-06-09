import 'dart:io';
import 'package:app/constant/app_color.dart';
import 'package:app/controller/c_usulan_konsultasi.dart';
import 'package:app/controller/c_data_harian.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/image_picker.dart';
import 'package:app/widget/request_painter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({super.key});

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  File? photo;

  String judul = '';
  String deskripsi = '';
  String downloadUrl = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cDataHarian = Provider.of<CDataHarian>(context, listen: false);
    final cAuth = Provider.of<CAuth>(context, listen: false).getDataProfile();
    final cUsulanKonsultasi =
        Provider.of<CUsulanKonsultasi>(context, listen: false);
    void trySave() async {
      final validation = await cUsulanKonsultasi.validasiForm(formKey, context);
      if (validation) {
        final indexActive = cDataHarian.indexActive();
        formKey.currentState!.save();
        // ignore: use_build_context_synchronously
        cUsulanKonsultasi.simpanUsulan(judul, deskripsi, cAuth.peternakanId,
            cAuth.id, photo, cDataHarian.musimList, indexActive, context);
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
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(
                          MediaQuery.of(context).size.width,
                          140,
                        ),
                        painter: RequestPainter(),
                      ),
                      const CustomBackButton(
                        color: AppColor.quaternary,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Text(
                            'Usulan Konsultasi',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tanggal'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue:
                            DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Masalah'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: judul,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Wajib diisi!";
                          }
                          return null;
                        },
                        onSaved: (newValue) => judul = newValue!,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Penjelasan'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Wajib diisi!";
                          }
                          return null;
                        },
                        onSaved: (newValue) => deskripsi = newValue!,
                        maxLines: 10,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Tambahkan Gambar'),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          final result = await showImagePicker(context);
                          if (result != null) {
                            setState(() {
                              photo = result;
                            });
                          }
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              image: photo != null
                                  ? DecorationImage(
                                      image: FileImage(photo!),
                                      fit: BoxFit.cover)
                                  : null,
                              color: AppColor.formcolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1.5, color: AppColor.formborder)),
                          child:
                              photo == null ? const Icon(Icons.camera) : null,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () => trySave(),
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColor.tertiary,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'SIMPAN',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.secondary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
