import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserController>(context);
    final isPemilik = userData.user.role == UserRole.pemilik;

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/profile-details'),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/profile_background.png"),
                      fit: BoxFit.cover),
                ),
                // height: 180,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: userData.user.downloadUrl.isEmpty
                              ? Image.asset(
                                  "assets/images/profile.png",
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData.user.downloadUrl)),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              FittedBox(
                                child: Text(
                                  userData.user.nama,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                userData.user.role,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            if (userData.user.role != UserRole.dokter)
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/farm-data',
                ),
                child: SizedBox(
                  height: 95,
                  child: Stack(children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/images/farm_bg.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 80,
                        child: const Text(
                          'Profil Peternakan',
                          style: TextStyle(
                              color: AppColor.tertiary,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 18,
                      child: Image.asset(
                        "assets/images/barn.jpg",
                        scale: 4.8,
                      ),
                    ),
                  ]),
                ),
              ),

            const SizedBox(
              height: 6,
            ),
            if (userData.user.role != UserRole.dokter)
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/request-list',
                    arguments: false),
                child: SizedBox(
                  height: 90,
                  child: Stack(children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/images/request_bg.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 80,
                        child: const Text(
                          'Usul Konsultasi',
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 18,
                      child: Image.asset(
                        "assets/images/req.png",
                        scale: 7,
                      ),
                    ),
                  ]),
                ),
              ),
            const SizedBox(
              height: 6,
            ),
            // Expanded(child: Container())
            if (userData.user.role != UserRole.dokter)
              SizedBox(
                height: 90,
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/season-list'),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/daily_background.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 80,
                        child: const Text(
                          'Data Harian',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 195, 85, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 25,
                    child: Image.asset(
                      "assets/images/book.png",
                      scale: 3.3,
                    ),
                  ),
                ]),
              ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              height: 90,
              child: Stack(children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, '/consultation-list'),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/daily_background.png"),
                            fit: BoxFit.cover),
                        // color: const Color.fromRGBO(213, 13, 0, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 80,
                      child: const Text(
                        'Konsultasi',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 195, 85, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 25,
                  child: Image.asset(
                    "assets/images/book.png",
                    scale: 3.3,
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              height: 90,
              child: Stack(children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => FirebaseAuth.instance.signOut(),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/logout_background.png"),
                            fit: BoxFit.cover),
                        // color: const Color.fromRGBO(213, 13, 0, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 80,
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 25,
                  child: Image.asset(
                    "assets/images/logout.png",
                    scale: 3.3,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
    // return Center(
    //   child: ElevatedButton(
    //     child: const Text('Log out'),
    //     onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
    //   ),
    // );
  }
}
