import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/widget/feedschedule.dart';
import 'package:app/widget/incomingconsultation.dart';
import 'package:app/widget/todaysrice.dart';
import 'package:app/widget/weatherhome.dart';
import 'package:app/widget/workinghours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context).getDataProfile();
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cAuth.role == UserRole.pemilik)
            InkWell(
              onTap: () => Navigator.of(context).pushNamed('/find-doctor'),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.formborder),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "Cari Dokter",
                            hintStyle: TextStyle(color: AppColor.formborder),
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    height: 40,
                    child: Image.asset("assets/images/data.png"),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: cAuth.downloadUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(cAuth.downloadUrl))
                    : Image.asset("assets/images/profile.png"),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selamat Datang",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    cAuth.nama,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (cAuth.role == UserRole.pengelola) const WeatherHome(),
          if (cAuth.role == UserRole.pemilik) const TodayExpenses(),
          if (cAuth.role != UserRole.dokter)
            const Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Jadwal Pakan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                FeedSchedule(),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          if (cAuth.role == UserRole.dokter)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IncomingSchedule(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Jam Kerja',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                WorkingHoursWiget()
              ],
            )
        ],
      ),
    );
  }
}
