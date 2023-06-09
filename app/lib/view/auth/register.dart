import 'package:app/constant/app_color.dart';
import 'package:app/constant/app_format.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/widget/custom_back_button.dart';
import 'package:app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  var alamat = '';
  var peternakanId = '';
  var dateController = TextEditingController();
  DateTime currentDate = DateTime.now();
  var roleValue = UserRole.pengelola;

  @override
  void initState() {
    dateController.text = AppFormat.dateFromDateTime(currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context, listen: false);
    void visible() {
      setState(() {
        isVisible = !isVisible;
      });
    }

    Future<String> onCompleteRegistration(String id, String role) async {
      String dokterDetailsId = '';
      String peternakanId = '';

      if (role == UserRole.pemilik || role == UserRole.pengelola) {
        peternakanId = id;
      } else {
        dokterDetailsId = id;
      }

      final result = await cAuth.register(
        email,
        name,
        password,
        roleValue,
        peternakanId,
        dokterDetailsId,
        AppFormat.intDateFromDateTime(currentDate),
        alamat,
      );
      return result!;
    }

    void tryRegister(BuildContext context) async {
      final validasi = await cAuth.validasiForm(
          context, formKey, email, password, alamat, name);
      if (validasi) {
        return;
      }
      if (roleValue == UserRole.pemilik) {
        // ignore: use_build_context_synchronously
        customDialog(context, 'Informasi Tambahan',
                'Isi data peternakan baru untuk melanjutkan proses pendaftaran')
            .then(
          (value) => Navigator.of(context)
              .pushNamed('/add-farm', arguments: onCompleteRegistration),
        );
      } else if (roleValue == UserRole.pengelola) {
        final isExist = await cAuth.checkPeternakanId(peternakanId);
        if (isExist) {
          onCompleteRegistration(peternakanId, UserRole.pengelola);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // ignore: use_build_context_synchronously
          customDialog(context, 'Gagal!', 'ID Peternakan tidak ditemukan!');
        }
      } else if (roleValue == UserRole.dokter) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/add-dokter',
            arguments: onCompleteRegistration);
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
              child: Stack(
                children: [
                  const CustomBackButton(color: AppColor.secondary),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset("assets/images/register_image.png",
                          width: 100),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
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
                                        onSaved: (newValue) => name = newValue!,
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
                                        onSaved: (newValue) =>
                                            alamat = newValue!,
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
                                          'Alamat',
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
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: dateController,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 15)),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 5),
                                            height: 35,
                                            child: InkWell(
                                              onTap: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: currentDate,
                                                  firstDate: DateTime(
                                                      DateTime.now().year -
                                                          100),
                                                  lastDate: DateTime.now(),
                                                ).then((value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      currentDate = value;
                                                      dateController.text =
                                                          AppFormat
                                                              .dateFromDateTime(
                                                                  value);
                                                    });
                                                  }
                                                });
                                              },
                                              child: Image.asset(
                                                  'assets/images/daily.png',
                                                  fit: BoxFit.fitHeight),
                                            ),
                                          ),
                                        ],
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
                                          'Tanggal Lahir',
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
                                        onChanged: (value) {
                                          if (value == UserRole.pengelola ||
                                              roleValue == UserRole.pengelola) {
                                            setState(() {
                                              roleValue = value!;
                                            });
                                          } else {
                                            roleValue = value!;
                                          }
                                        },
                                        items: const [
                                          DropdownMenuItem(
                                            value: UserRole.pemilik,
                                            child: Text('Pemilik'),
                                          ),
                                          DropdownMenuItem(
                                            value: UserRole.pengelola,
                                            child: Text('Pengelola'),
                                          ),
                                          DropdownMenuItem(
                                            value: UserRole.dokter,
                                            child: Text('Dokter'),
                                          )
                                        ],
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
                                  height: 15,
                                ),
                                if (roleValue == UserRole.pengelola)
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
                                          onSaved: (newValue) =>
                                              peternakanId = newValue!,
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
                                            'ID Peternakan',
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
                                  onTap: () => tryRegister(context),
                                  child: Container(
                                    width: 260,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.secondary,
                                    ),
                                    child: const Text(
                                      'DAFTAR',
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
                    ],
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
