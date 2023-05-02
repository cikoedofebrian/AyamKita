import 'dart:io';
import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/consultationrequest.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/customdialog.dart';
import 'package:app/widget/image_shower.dart';
import 'package:app/widget/imagepicker.dart';
import 'package:app/widget/requestpainter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({super.key});

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as ConsultationRequestModel;
    void tryDelete() async {
      bool isConfirm = false;
      await NDialog(
        title: const Text(
          'Konfirmasi',
          textAlign: TextAlign.center,
        ),
        content: const Text("Yakin ingin menghapus?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              isConfirm = true;
              Navigator.of(context).pop();
            },
            child: const Text('Iya'),
          )
        ],
      ).show(context);
      if (isConfirm) {
        Provider.of<ConsultationRequestController>(context, listen: false)
            .deleteData(data.usulanKonsultasiId);
        customDialog(context, 'Berhasil', 'Data berhasil dihapus')
            .then((value) => Navigator.pop(context));
      }
    }

    final userController = Provider.of<UserController>(context, listen: false);

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
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(
                          MediaQuery.of(context).size.width,
                          140,
                        ),
                        painter: RequestPainter(),
                      ),
                      const CustomBackButton(
                        color: AppColor.quaternary,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Text(
                            'Usulan Konsultasi',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tanggal'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue:
                            DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Masalah'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: data.judul,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Penjelasan'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: data.deskripsi,
                        enabled: false,
                        maxLines: 10,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Tambahkan Gambar'),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (data.downloadUrl.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageShower(downloadUrl: data.downloadUrl),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColor.formcolor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1.5, color: AppColor.formborder),
                            image: DecorationImage(
                              image: data.downloadUrl.isNotEmpty
                                  ? NetworkImage(data.downloadUrl)
                                  : const AssetImage(
                                          'assets/images/no-photo-available.png')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => tryDelete(),
                              child: Material(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    'HAPUS',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.tertiary),
                                  ),
                                ),
                              ),
                            ),
                            if (Provider.of<UserController>(context,
                                        listen: false)
                                    .user
                                    .role ==
                                UserRole.pemilik)
                              InkWell(
                                onTap: () => tryDelete(),
                                child: Material(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColor.tertiary,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      'SETUJUI',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.secondary),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
