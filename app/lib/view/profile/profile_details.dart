import 'dart:io';
import 'package:app/constant/appcolor.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late String name;
  late String role;
  late String number;
  late String address;
  late String email;
  late String farmName;
  late String since;
  late String imageUrl;
  // XFile? newPhoto;
  File? photo;
  bool isEditable = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final userController = Provider.of<UserController>(context, listen: false);
    super.initState();
    name = userController.name;
    role = userController.role;
    number = userController.number;
    address = userController.address;
    email = userController.email;
    farmName = userController.farmName;
    since = userController.since;
    imageUrl = userController.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    void showImagePicker() {
      final ImagePicker picker = ImagePicker();
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Text(
                      'Pilih salah satu metode dibawah :',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Ambil foto baru'),
                    onTap: () async {
                      final XFile? pickedPhoto =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedPhoto != null) {
                        setState(() {
                          photo = File(pickedPhoto.path);
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.image),
                    title: const Text('Pilih dari galeri'),
                    onTap: () async {
                      final XFile? pickedPhoto =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedPhoto != null) {
                        setState(() {
                          photo = File(pickedPhoto.path);
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          });
    }

    void trySave() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (photo != null) {
          final upload = await FirebaseStorage.instance
              .ref('/profile-images/${FirebaseAuth.instance.currentUser!.uid}')
              .putFile(
                File(photo!.path),
              );
          final url = await upload.ref.getDownloadURL();
          imageUrl = url;
        }

        final userController =
            Provider.of<UserController>(context, listen: false);
        final trimmedname = name.trim();
        final trimmedaddress = address.trim();
        final trimmedimageUrl = imageUrl.trim();
        final trimmednumber = number.trim();
        if (trimmedname != userController.name ||
            trimmedaddress != userController.address ||
            trimmednumber != userController.number ||
            trimmedimageUrl != userController.imageUrl) {
          Provider.of<UserController>(context, listen: false).updateData(
            trimmedname,
            trimmednumber,
            trimmedaddress,
            trimmedimageUrl,
          );
          customDialog(
              context, "Berhasil!", "Perubahan data berhasil dilakukan");
          setState(() {
            isEditable = !isEditable;
          });
        } else {
          customDialog(
              context, "Tidak berhasil", "Tidak ada data yang dirubah");
        }
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
        body: SingleChildScrollView(
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
                        // Positioned(
                        //   top: 110,
                        //   left: MediaQuery.of(context).size.width * 0.5 - 50,
                        //   child: SizedBox(
                        //     child: Image.asset("assets/images/profile.png"),
                        //     width: 100,
                        //   ),
                        // ),
                        Container(
                          width: double.infinity,
                          height: 220,
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 100,
                                child: imageUrl.isEmpty && photo == null
                                    ? Image.asset("assets/images/profile.png")
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: photo != null
                                                ? FileImage(photo!)
                                                : NetworkImage(imageUrl)
                                                    as ImageProvider,
                                            fit: BoxFit.fill,
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
                                    onTap: showImagePicker,
                                    child: const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColor.tertiary,
                                      child: Icon(
                                        Icons.camera,
                                        color: AppColor.secondary,
                                        size: 20,
                                      ),
                                    )
                                        .animate(target: isEditable ? 1 : 1)
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
                        const CustomBackButton(color: AppColor.quaternary),
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
                          ).animate(target: isEditable ? 0 : 0).fadeOut(),
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
                            initialValue: name,
                            enabled: isEditable,
                            onSaved: (newValue) => name = newValue!,
                            key: const ValueKey('name'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Email'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            enabled: false,
                            initialValue: email,
                            key: const ValueKey('email'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('No Telepon'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            enabled: isEditable,
                            initialValue: number,
                            validator: (value) {
                              if (value!.isNotEmpty &&
                                  int.tryParse(value) == null) {
                                return "Tolong isi dengan angka";
                              }
                              return null;
                            },
                            onSaved: (newValue) => number = newValue!,
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
                            onSaved: (newValue) => address = newValue!,
                            initialValue: address,
                            enabled: isEditable,
                            key: const ValueKey('address'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Mendaftar Sebagai'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      initialValue: role,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Semenjak'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      initialValue: since,
                                      enabled: false,
                                      key: ValueKey('since'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Peternakan'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            initialValue: farmName,
                            enabled: false,
                            key: ValueKey('farmName'),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: isEditable ? trySave : null,
                              child: Material(
                                borderRadius: BorderRadius.circular(16),
                                color: isEditable
                                    ? AppColor.tertiary
                                    : Colors.grey,
                                child: Padding(
                                  child: Text(
                                    'SIMPAN',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isEditable
                                            ? AppColor.secondary
                                            : Colors.black),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                              ).animate(target: isEditable ? 0 : 1).shake(),
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
