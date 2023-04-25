import 'package:app/constant/appcolor.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Container(
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
                        child: Stack(children: [
                          SizedBox(
                            width: 100,
                            child: Image.asset("assets/images/profile.png"),
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColor.tertiary,
                              child: Icon(
                                Icons.edit,
                                color: AppColor.secondary,
                                size: 20,
                              ),
                            ),
                          )
                        ]),
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
                      const CustomBackButton()
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Email'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('No Telepon'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Alamat'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(),
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
                                initialValue: 'Pengelola',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
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
                              TextFormField(),
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
                    TextFormField(),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColor.tertiary,
                        child: Padding(
                          child: Text(
                            'SIMPAN',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondary),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
