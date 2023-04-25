import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var isVisible = true;
  final formKey = GlobalKey<FormState>();
  var name = '';
  var email = '';
  var password = '';
  var roleValue = UserRole.pengelola;

  @override
  Widget build(BuildContext context) {
    void visible() {
      setState(() {
        isVisible = !isVisible;
      });
    }

    void trySignUp(BuildContext context) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          FirebaseFirestore.instance
              .collection('account')
              .doc(value.user!.uid)
              .set(
            {"role": roleValue, "name": name, "email": email},
          ).then((value) => Navigator.pop(context));
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            content: Text('Something went wrong, Please try again!'),
          ),
        );
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SizedBox(
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(color: AppColor.secondary),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/register_image.png",
                            width: 120),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
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
                                        height: 70,
                                      ),
                                      Positioned(
                                        width: 260,
                                        top: 10,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            }
                                          },
                                          onSaved: (newValue) =>
                                              name = newValue!,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
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
                                            'Nama',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 70,
                                      ),
                                      Positioned(
                                        width: 260,
                                        top: 10,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            }
                                          },
                                          onSaved: (newValue) =>
                                              email = newValue!,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
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
                                            'Email',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 70,
                                      ),
                                      Positioned(
                                        width: 260,
                                        top: 10,
                                        child: TextFormField(
                                          obscureText: isVisible,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            }
                                          },
                                          onSaved: (newValue) =>
                                              password = newValue!,
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: visible,
                                                  icon: Icon(isVisible
                                                      ? Icons
                                                          .visibility_off_outlined
                                                      : Icons
                                                          .visibility_outlined)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
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
                                            'Password',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                      ),
                                      Positioned(
                                        width: 260,
                                        top: 10,
                                        child: DropdownButtonFormField(
                                          value: roleValue,
                                          onChanged: (value) =>
                                              roleValue = value!,
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('Pemilik'),
                                              value: UserRole.pemilik,
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Pengelola'),
                                              value: UserRole.pengelola,
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Dokter'),
                                              value: UserRole.dokter,
                                            )
                                          ],
                                          // decoration: InputDecoration(
                                          //     contentPadding:
                                          //         const EdgeInsets.symmetric(
                                          //             horizontal: 15)),
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
                                            'Register Sebagai',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () => trySignUp(context),
                                    child: Container(
                                      width: 260,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.secondary,
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
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
