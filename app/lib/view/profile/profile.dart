import 'package:app/constant/appcolor.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
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
                        child: userData.imageUrl.isEmpty
                            ? Image.asset(
                                "assets/images/profile.png",
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userData.imageUrl)),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 180,
                            child: FittedBox(
                              child: Text(
                                userData.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            userData.role,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
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
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/request-list'),
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
                  top: 0,
                  right: 18,
                  child: Image.asset(
                    "assets/images/req.png",
                    scale: 6,
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          // Expanded(child: Container())
          SizedBox(
            height: 90,
            child: Stack(children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/data-history'),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image:
                              AssetImage("assets/images/daily_background.png"),
                          fit: BoxFit.cover),
                      // color: const Color.fromRGBO(213, 13, 0, 1),
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
                  onTap: () => FirebaseAuth.instance.signOut(),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image:
                              AssetImage("assets/images/logout_background.png"),
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
          const SizedBox(
            height: 6,
          ),
        ],
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
