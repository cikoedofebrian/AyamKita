import 'package:app/constant/appcolor.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/controller/weathercontroller.dart';
// import 'package:app/widget/customnavbar.dart';
import 'package:app/widget/weatherhome.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

// return FutureBuilder(
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                       child: LoadingAnimationWidget.inkDrop(
//                           color: Colors.orange, size: 40));
//                 }
//                 return DashBoard();
//               },

//             );

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: Future.wait([
              Provider.of<UserController>(context, listen: false).fetchData(),
              Provider.of<WeatherController>(context, listen: false).fetchData()
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: Colors.orange, size: 60));
              }
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.formborder),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Cari Dokter",
                                  hintStyle:
                                      TextStyle(color: AppColor.formborder),
                                  icon: Icon(Icons.search),
                                  border: InputBorder.none,
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
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Image.asset("assets/images/profile.png"),
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
                              userController.name,
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
                    WeatherHome(),
                    // Text(userController.email),
                    // Text(userController.name),
                    // Text(userController.role)
                  ],
                ),
              );
            }),
        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut();
        //     },
        //     child: Text('The'),
        //   ),
        // ),
      ),
    );
  }
}
