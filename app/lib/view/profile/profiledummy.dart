import 'package:app/constant/appcolor.dart';
import 'package:app/model/usermodel.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileDummy extends StatefulWidget {
  const ProfileDummy({super.key});

  @override
  State<ProfileDummy> createState() => _ProfileDummyState();
}

class _ProfileDummyState extends State<ProfileDummy> {
  // late String name;
  // late String role;
  // late String number;
  // late String address;
  // late String email;
  // late String since;
  // late String imageUrl;
  // late Future future;
  // File? photo;
  // bool isEditable = false;
  final formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   final CAuth = Provider.of<CAuth>(context, listen: false);
  //   future = CAuth.getFarmName();
  //   name = CAuth.user.nama;
  //   role = CAuth.user.role;
  //   number = CAuth.user.noTelepon;
  //   address = CAuth.user.alamat;
  //   email = CAuth.user.email;
  //   since = CAuth.user.tanggalPendaftaran;
  //   imageUrl = CAuth.user.downloadUrl;

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final Future<UserModel> future =
        ModalRoute.of(context)!.settings.arguments as Future<UserModel>;

    // final cAuth = Provider.of<CAuth>(context);
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
            final data = snapshot.data!;
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
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 220,
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 100,
                                child: data.downloadUrl.isEmpty
                                    ? Image.asset("assets/images/profile.png")
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(data.downloadUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 100,
                                        width: 100,
                                      ),
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
                                initialValue: data.nama,
                                enabled: false,
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
                                initialValue: data.email,
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
                                enabled: false,
                                initialValue: data.noTelepon.isEmpty
                                    ? '-'
                                    : data.noTelepon,
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
                                initialValue: data.alamat,
                                enabled: false,
                                key: const ValueKey('address'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Mendaftar Sebagai'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                            enabled: false,
                                            initialValue: data.role),
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
                                        const Text('Semenjak'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          initialValue: data.tanggalPendaftaran,
                                          enabled: false,
                                          key: const ValueKey('since'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
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
          },
        ),
      ),
    );
  }
}
