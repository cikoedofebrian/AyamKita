import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/chickenpricecontroller.dart';
import 'package:app/controller/feedcontroller.dart';
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
    final feedController = Provider.of<FeedController>(context);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: Future.wait([
              Provider.of<UserController>(context, listen: false).fetchData(),
              Provider.of<WeatherController>(context, listen: false)
                  .fetchData(),
              Provider.of<ChickenPriceController>(context, listen: false)
                  .fetchData(),
              Provider.of<FeedController>(context, listen: false).fetchData()
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: Colors.orange, size: 60));
              }
              return SingleChildScrollView(
                child: Padding(
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
                                  border:
                                      Border.all(color: AppColor.formborder),
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
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Data Absensi hari ini : '),
                              Text(AppFormat.date(DateTime.now().toString()))
                            ],
                          ),
                          // Text(feedController.list[0].date),
                          // ...List.generate(
                          //   feedController.list.length,
                          //   (index) => Container(
                          //     child: Text(feedController.list[index].date),
                          //   ),
                          // ),
                        ],
                      )
                      // Material(
                      //   elevation: 5,
                      //   borderRadius: BorderRadius.circular(10),
                      //   color: Colors.orange,
                      //   child: Padding(
                      //     padding:
                      //         EdgeInsets.only(bottom: 20, left: 20, top: 20),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Rp 30.000,00",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .headlineMedium!
                      //               .copyWith(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.white),
                      //         ),
                      //         Text(
                      //           "+42% dibanding kemarin",
                      //           // "+42% dibanding kemarin",
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: 16),
                      //         ),
                      //         SizedBox(height: 20),
                      //         Container(
                      //           padding: EdgeInsets.symmetric(
                      //               vertical: 5, horizontal: 20),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(10),
                      //               bottomLeft: Radius.circular(10),
                      //             ),
                      //             color: Colors.white,
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: [
                      //               Text('See more'),
                      //               Icon(Icons.navigate_next)
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      ,
                      ElevatedButton(
                          // onPressed: () => Provider.of<ChickenPriceController>(
                          //         context,
                          //         listen: false)
                          //     .addData(),
                          onPressed: () => feedController.fillAbsence(),
                          child: Text('add'))
                      // Text(userController.email),
                      // Text(userController.name),
                      // Text(userController.role)
                    ],
                  ),
                ),
              );
            }),
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
