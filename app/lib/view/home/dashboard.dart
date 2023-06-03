import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/usercontroller.dart';
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
    final userController = Provider.of<UserController>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userController.user.role == UserRole.pemilik)
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
                child: userController.user.downloadUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(userController.user.downloadUrl))
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
                    userController.user.nama,
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
          if (userController.user.role == UserRole.pengelola)
            const WeatherHome(),
          if (userController.user.role == UserRole.pemilik)
            const TodayExpenses(),
          if (userController.user.role != UserRole.dokter)
            Column(
              children: const [
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
          if (userController.user.role == UserRole.dokter)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
