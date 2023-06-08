import 'package:app/constant/role.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/widget/profile_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context);
    final userData = cAuth.getDataProfile();
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
                          child: userData.downloadUrl.isEmpty
                              ? Image.asset(
                                  "assets/images/profile.png",
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData.downloadUrl)),
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
                                  userData.nama,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                userData.role,
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
            if (userData.role != UserRole.dokter) ...[
              const SizedBox(
                height: 10,
              ),
              const ProfileItem(
                  assetName: 'assets/images/barn.jpg',
                  routeName: '/farm-data',
                  title: 'Profil Peternakan'),
            ],
            if (userData.role != UserRole.dokter) ...[
              const SizedBox(
                height: 10,
              ),
              const ProfileItem(
                assetName: "assets/images/req.png",
                routeName: '/request-list',
                title: 'Usulan Konsultasi',
                size: 9,
                argument: false,
              ),
            ],
            if (userData.role != UserRole.dokter) ...[
              const SizedBox(
                height: 10,
              ),
              const ProfileItem(
                  assetName: "assets/images/book.png",
                  routeName: "/season-list",
                  title: "Data Harian")
            ],
            if (userData.role != UserRole.pengelola) ...[
              const SizedBox(
                height: 10,
              ),
              const ProfileItem(
                assetName: "assets/images/book.png",
                routeName: "/consultation-list",
                title: 'Konsultasi',
              )
            ],
            const SizedBox(
              height: 10,
            ),
            ProfileItem(
              assetName: "assets/images/logout.png",
              routeName: "/login",
              title: "Keluar",
              function: () {
                cAuth.setLoading(true);
                Navigator.pushNamed(context, '/login');
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
