import 'package:app/constant/role.dart';
import 'package:app/controller/chickenpricecontroller.dart';
import 'package:app/controller/consultationcontroller.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/feedcontroller.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/controller/weathercontroller.dart';
import 'package:app/controller/workinghourscontroller.dart';
import 'package:app/view/home/dashboard.dart';
import 'package:app/view/home/middle_page.dart';
import 'package:app/view/profile/profile.dart';
import 'package:app/widget/customnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future future;
  @override
  void initState() {
    future = getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    // isLoading = true;
    final cAuth = Provider.of<CAuth>(context, listen: false);
    await cAuth.fetchData().then(
          (value) => cAuth.getDataProfile().role == UserRole.dokter
              ? future = Future.wait([
                  cAuth.fetchDokterDetails(),
                  Provider.of<ConsultationController>(context, listen: false)
                      .fetchDataForDokter(),
                  Provider.of<WorkingHoursControllers>(context, listen: false)
                      .fetchData(FirebaseAuth.instance.currentUser!.uid)
                ]).then((value) => cAuth.setLoading(false))
              : future = Future.wait(
                  [
                    Provider.of<WeatherController>(context, listen: false)
                        .fetchData(),
                    Provider.of<ChickenPriceController>(context, listen: false)
                        .fetchData(),
                    Provider.of<FeedController>(context, listen: false)
                        .fetchData(cAuth.getDataProfile().peternakanId),
                    Provider.of<DailyController>(context, listen: false)
                        .fetchData(cAuth.getDataProfile().peternakanId),
                    Provider.of<ConsultationController>(context, listen: false)
                        .fetchDataForPemilik(
                            cAuth.getDataProfile().peternakanId),
                  ],
                ).then((value) => cAuth.setLoading(false)),
        );
  }

  final List<Widget> _page = const [
    DashBoard(),
    MiddlePage(),
    Profile(),
  ];
  int _selectedPage = 0;

  void changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cAuth = Provider.of<CAuth>(context);
    return Scaffold(
      body: cAuth.isLoading == true
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: Colors.orange, size: 60),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () {
                      cAuth.setLoading(true);
                      return getUserData();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: _page[_selectedPage],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CustomNavbar(
                      index: _selectedPage,
                      changePage: changePage,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
