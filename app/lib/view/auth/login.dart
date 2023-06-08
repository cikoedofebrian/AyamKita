import 'package:app/constant/appcolor.dart';
import 'package:app/controller/c_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isRememberMe = false;
  var isVisible = true;
  final formKey = GlobalKey<FormState>();
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

  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CAuth cAuth = Provider.of<CAuth>(context);
    final size = MediaQuery.of(context).size;
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
                children: [
                  Image.asset("assets/images/login_image.png", width: 120),
                  const SizedBox(height: 30),
                  Container(
                    width: size.width,
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
                                    controller: emailCon,
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
                                    controller: passwordCon,
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
                            InkWell(
                              onTap: () => cAuth.resumeLogin(
                                context,
                                formKey,
                                emailCon.text,
                                passwordCon.text,
                              ),
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
                                  child: const Text(
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
