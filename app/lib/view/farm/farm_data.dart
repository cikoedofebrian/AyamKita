import 'dart:io';
import 'package:app/constant/app_color.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_peternakan.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/model/m_peternakan.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/custom_dialog.dart';
import 'package:app/widget/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FarmData extends StatefulWidget {
  const FarmData({super.key});

  @override
  State<FarmData> createState() => _FarmDataState();
}

class _FarmDataState extends State<FarmData> {
  String nama = '';
  int luas = 0;
  String alamat = '';
  File? photo;
  bool isEditable = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context, listen: false);
    final isPemilik = cAuth.getDataProfile().role == UserRole.pemilik;
    final peternakanController = Provider.of<CPeternakan>(context);
    MPeternakan? peternakanData =
        ModalRoute.of(context)!.settings.arguments as MPeternakan?;

    if (peternakanData == null) {
      if (peternakanController.isLoading) {
        peternakanController
            .fetchFarmData(cAuth.getDataProfile().peternakanId)
            .then((value) =>
                peternakanData = peternakanController.getDataProfile());
      } else {
        peternakanData = peternakanController.getDataProfile();
      }
    }
    void trySave() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (nama == peternakanData!.nama &&
            peternakanData!.alamat == alamat &&
            peternakanData!.luas == luas &&
            photo == null) {
          customDialog(context, 'Gagal!', 'Tidak ada data yang dirubah!');
        } else {
          String photoUrl = '';
          if (photo != null) {
            final upload = await FirebaseStorage.instance
                .ref('peternakan_photo/${peternakanData!.peternakanId}}')
                .putFile(photo!);
            photoUrl = await upload.ref.getDownloadURL();
          }
          peternakanController.updateProfilePeternakn(
              nama, alamat, luas, photoUrl);
          // ignore: use_build_context_synchronously
          customDialog(context, 'Berhasil', 'Perubahan data berhasil!');
        }
      } else {
        customDialog(context, 'Gagal!', 'Data tidak valid!');
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
        body: peternakanController.isLoading == true
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColor.secondary,
                  size: 60,
                ),
              )
            : SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 240,
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 190,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/images/profile_bg.png',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 220,
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: peternakanData!
                                                  .downloadUrl.isEmpty &&
                                              photo == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/no-photo-available.png"),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                image: DecorationImage(
                                                  image: photo != null
                                                      ? FileImage(photo!)
                                                      : NetworkImage(
                                                              peternakanData!
                                                                  .downloadUrl)
                                                          as ImageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              height: 100,
                                              width: 100,
                                            ),
                                    ),
                                    if (isEditable)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            File? result =
                                                await showImagePicker(context);
                                            if (result != null) {
                                              setState(() {
                                                photo = result;
                                              });
                                            }
                                          },
                                          child: const CircleAvatar(
                                            radius: 16,
                                            backgroundColor: AppColor.tertiary,
                                            child: Icon(
                                              Icons.camera,
                                              color: AppColor.secondary,
                                              size: 20,
                                            ),
                                          )
                                              .animate(
                                                  target: isEditable ? 1 : 1)
                                              .shake(),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 95,
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'PROFILE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                              const CustomBackButton(
                                  color: AppColor.quaternary),
                              if (isPemilik)
                                Positioned(
                                  right: 30,
                                  top: 50,
                                  child: CircleAvatar(
                                    backgroundColor: isEditable
                                        ? AppColor.tertiary
                                        : Colors.transparent,
                                    radius: 28,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditable = !isEditable;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                      .animate(target: isEditable ? 0 : 0)
                                      .fadeOut(),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Nama'),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onSaved: (newValue) => nama = newValue!,
                                  initialValue: peternakanData!.nama,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                  enabled: isEditable,
                                  key: const ValueKey('name'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Luas ( m2 )'),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onSaved: (newValue) =>
                                      luas = int.parse(newValue!),
                                  enabled: isEditable,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Wajib diisi";
                                    } else if (value.isNotEmpty &&
                                        int.tryParse(value) == null) {
                                      return "Tolong isi dengan angka";
                                    }
                                    return null;
                                  },
                                  initialValue: peternakanData!.luas.toString(),
                                  key: const ValueKey('email'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Beroperasi Semenjak'),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  enabled: false,
                                  initialValue: peternakanData!.semenjak,

                                  // onSaved: (newValue) => number = newValue!,
                                  key: const ValueKey('number'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Alamat'),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Wajib diisi";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => alamat = newValue!,
                                  initialValue: peternakanData!.alamat,
                                  enabled: isEditable,
                                  key: const ValueKey('address'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('ID Peternakan'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        enabled: false,
                                        initialValue:
                                            peternakanData!.peternakanId,
                                        key: const ValueKey('semenjak'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: peternakanData!.peternakanId,
                                          ),
                                        );
                                        customDialog(context, 'Berhasil!',
                                            'ID Peternakan berhasil di salin!');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: const Icon(
                                          Icons.copy,
                                          color: AppColor.formborder,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (isPemilik) {
                                            Navigator.of(context)
                                                .pushNamed('/pengelola-list');
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              '/profile-dummy',
                                              arguments: peternakanController
                                                  .getDataProfilePemilik(
                                                      peternakanData!
                                                          .peternakanId),
                                            );
                                          }
                                        },
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: AppColor.secondary,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Text(
                                              isPemilik
                                                  ? 'LIHAT PENGELOLA'
                                                  : 'LIHAT PEMILIK',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.tertiary),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (isPemilik)
                                        InkWell(
                                          onTap: trySave,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: isEditable
                                                ? AppColor.tertiary
                                                : Colors.grey,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Text(
                                                'SIMPAN',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: isEditable
                                                        ? AppColor.secondary
                                                        : Colors.black),
                                              ),
                                            ),
                                          )
                                              .animate(
                                                  target: isEditable ? 0 : 1)
                                              .shake(),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
