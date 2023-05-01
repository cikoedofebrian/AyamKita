import 'dart:io';
import 'package:app/constant/appcolor.dart';
import 'package:app/controller/farmcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:app/widget/imagepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FarmData extends StatefulWidget {
  const FarmData({super.key});

  @override
  State<FarmData> createState() => _FarmDataState();
}

class _FarmDataState extends State<FarmData> {
  late Future future;
  File? photo;
  bool isEditable = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    future = Provider.of<PeternakanController>(context, listen: false)
        .fetchFarmData(Provider.of<UserController>(context, listen: false)
            .user
            .peternakanId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPemilik = ModalRoute.of(context)!.settings.arguments as bool;
    final userController = Provider.of<UserController>(context, listen: false);
    final peternakanController =
        Provider.of<PeternakanController>(context, listen: false);

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
        body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: Colors.orange, size: 60),
                );
              }
              return SingleChildScrollView(
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
                                  )),
                              Container(
                                width: double.infinity,
                                height: 220,
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: peternakanController.farmData!
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
                                              // child: Image.asset(
                                              //     "assets/images/no-photo-available.png"),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                image: DecorationImage(
                                                  image: photo != null
                                                      ? FileImage(photo!)
                                                      : NetworkImage(
                                                              peternakanController
                                                                  .farmData!
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
                                      icon: Icon(
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
                                  initialValue:
                                      peternakanController.farmData!.nama,
                                  enabled: isEditable,
                                  // onSaved: (newValue) => name = newValue!,
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
                                  enabled: isEditable,
                                  initialValue: peternakanController
                                      .farmData!.luas
                                      .toString(),
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
                                  initialValue:
                                      peternakanController.farmData!.semenjak,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Wajib diisi";
                                    } else if (value.isNotEmpty &&
                                        int.tryParse(value) == null) {
                                      return "Tolong isi dengan angka";
                                    }
                                    return null;
                                  },
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
                                  // onSaved: (newValue) => address = newValue!,
                                  initialValue:
                                      peternakanController.farmData!.alamat,
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
                                TextFormField(
                                  enabled: false,
                                  initialValue: peternakanController
                                      .farmData!.peternakanId,
                                  key: const ValueKey('semenjak'),
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
                                                context, '/profile-dummy',
                                                arguments: peternakanController
                                                    .seePemilik());
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
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: isEditable
                                              ? AppColor.tertiary
                                              : Colors.grey,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
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
                                            .animate(target: isEditable ? 0 : 1)
                                            .shake(),
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
              );
            }),
      ),
    );
  }
}
