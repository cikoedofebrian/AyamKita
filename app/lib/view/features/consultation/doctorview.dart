import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/c_usulan_konsultasi.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/model/finddoctormodel.dart';
import 'package:app/widget/customtop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final rawData = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final data = rawData[0] as FindDoctorModel;
    final isActive = data.ifCurrentlyOpen(AppFormat.getCurrentDayIndex());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 160,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/profile_background.png'),
                              fit: BoxFit.cover)),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 69,
                            backgroundColor: AppColor.tertiary,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: data.imageUrl.isEmpty
                                  ? const AssetImage(
                                      'assets/images/profile.png',
                                    )
                                  : NetworkImage(data.imageUrl)
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. ${data.nama}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data.lokasi,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'TENTANG',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.deskripsi,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'JAM KERJA',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...data.hoursList
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                                left: 40, bottom: 10, top: 10),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColor.tertiary,
                                  radius: 8,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${AppFormat.getWeekName(e.day)}, Jam ${AppFormat.dayTimeToString(e.mulai)} - ${AppFormat.dayTimeToString(e.berakhir)}",
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(
                      height: 80,
                    ),
                  ]),
            ),
          ),
          const CustomTop(title: 'Profil Dokter'),
          if (rawData[1] as bool)
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    Provider.of<FindDoctorController>(context, listen: false)
                        .setSelectedModel(data);
                    Navigator.pushNamed(context, '/request-list',
                            arguments: true)
                        .then((value) => Provider.of<CUsulanKonsultasi>(context,
                                listen: false)
                            .selectRequest(""));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isActive ? AppColor.tertiary : Colors.grey,
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: const Text(
                      'KONSULTASI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
