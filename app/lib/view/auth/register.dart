import 'package:app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var isRememberMe = false;
  var isVisible = true;
  @override
  Widget build(BuildContext context) {
    void rememberMe() {
      setState(() {
        isRememberMe = !isRememberMe;
      });
    }

    void visible() {
      setState(() {
        isVisible = !isVisible;
      });
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
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                      child: Material(
                        borderRadius: BorderRadius.circular(100),
                        elevation: 4,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundColor: AppColor.tertiary,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColor.secondary,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.navigate_before_rounded,
                                color: AppColor.tertiary,
                              ),
                              iconSize: 45,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      )),
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
                            boxShadow: [
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
                                            'Username',
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
                                          onChanged: (value) => null,
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('Pemilik'),
                                              value: "Pemilik",
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Pengelola'),
                                              value: "Pengelola",
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Dokter'),
                                              value: "Dokter",
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
                                  Container(
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
