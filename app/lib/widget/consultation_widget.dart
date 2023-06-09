import 'package:app/constant/app_color.dart';
import 'package:app/constant/app_format.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_konsultasi.dart';
import 'package:app/model/m_konsultasi.dart';
import 'package:app/model/m_peternakan.dart';
import 'package:app/model/m_akun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:provider/provider.dart';

class ConsultationWidget extends StatelessWidget {
  const ConsultationWidget(
      {super.key, required this.data, required this.isPemilik});

  final MKonsultasi data;
  final bool isPemilik;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait(
          [
            data.getFarmData(),
            data.getData(UserRole.dokter),
            data.getConsultationRequest()
          ],
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          final userData = snapshot.data![1] as MAkun;
          final peternakanModel = snapshot.data![0] as MPeternakan;
          final imageUrl =
              isPemilik ? peternakanModel.downloadUrl : userData.downloadUrl;
          return InkWell(
            onTap: () {
              Provider.of<CKonsultasi>(context, listen: false)
                  .setSelectedChat(data.konsultasiId);
              Navigator.of(context).pushNamed('/consultation-view', arguments: [
                snapshot.data![0],
                snapshot.data![1],
                snapshot.data![2],
                data,
              ]);
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.secondary,
                image: const DecorationImage(
                  image: AssetImage("assets/images/requestlist_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPemilik
                            ? peternakanModel.nama
                            : "Dr. ${userData.nama}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(
                        AppFormat.dateFromDateTime(data.tanggal),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.tertiary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(data.status.capitalize()),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: imageUrl.isEmpty
                          ? const AssetImage("assets/images/profile.png")
                          : NetworkImage(imageUrl) as ImageProvider,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
