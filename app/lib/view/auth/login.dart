import 'package:app/constant/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;

    void tryLogin(BuildContext context) async {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "ciko@gmail.com", password: "cikociko");
      if (result != null) {
        print(result.user);
      }
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //           content: Text("Email can't be empty!"),
      //         ));
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/login_image.png", width: 120),
                  SizedBox(height: 30),
                  Container(
                    width: size.width,
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
                                    validator: (value) =>
                                        "Please input some value",
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
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
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 260,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                        width: 20,
                                        child: Transform.scale(
                                          scale: 0.9,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: AppColor.secondary,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value: isRememberMe,
                                            onChanged: (value) => rememberMe(),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Remember me?',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Forgot password?',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () => tryLogin(context),
                              child: Container(
                                width: 260,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.secondary,
                                ),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account ? ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                InkWell(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/register'),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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



                      // Container(
                      //   child: InputDecorator(
                      //     decoration: InputDecoration(
                      //       labelText: 'XP',
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //     ),
                      //     child: TextField(
                      //       decoration: InputDecoration.collapsed(hintText: ""),
                      //     ),
                      //   ),
                      // )