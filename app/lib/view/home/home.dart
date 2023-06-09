import 'package:app/constant/role.dart';
import 'package:app/controller/c_harga_pasar.dart';
import 'package:app/controller/c_konsultasi.dart';
import 'package:app/controller/c_data_harian.dart';
import 'package:app/controller/c_jadwal_pakan.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/controller/c_info_cuaca.dart';
import 'package:app/controller/c_jam_kerja.dart';
import 'package:app/view/home/dashboard.dart';
import 'package:app/view/home/middle_page.dart';
import 'package:app/view/profile/profile.dart';
import 'package:app/widget/custom_navbar.dart';
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
                  Provider.of<CKonsultasi>(context, listen: false)
                      .fetchDataForDokter(),
                  Provider.of<MJamKerjaControllers>(context, listen: false)
                      .fetchData(FirebaseAuth.instance.currentUser!.uid)
                ]).then((value) => cAuth.setLoading(false))
              : future = Future.wait(
                  [
                    Provider.of<CInfoCuaca>(context, listen: false).fetchData(),
                    Provider.of<CHargaPasar>(context, listen: false)
                        .fetchData(),
                    Provider.of<CJadwalPakan>(context, listen: false)
                        .fetchData(cAuth.getDataProfile().peternakanId),
                    Provider.of<CDataHarian>(context, listen: false)
                        .fetchData(cAuth.getDataProfile().peternakanId),
                    Provider.of<CKonsultasi>(context, listen: false)
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
