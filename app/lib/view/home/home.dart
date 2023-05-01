import 'package:app/controller/chickenpricecontroller.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/feedcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/controller/weathercontroller.dart';
import 'package:app/view/farm/add_data.dart';
import 'package:app/view/home/dashboard.dart';
import 'package:app/view/profile/profile.dart';
import 'package:app/widget/customnavbar.dart';
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
    final userController = Provider.of<UserController>(context, listen: false);
    await userController.fetchData().then(
          (value) => future = Future.wait(
            [
              Provider.of<FeedController>(context, listen: false)
                  .fetchData(userController.user.peternakanId),
              Provider.of<DailyController>(context, listen: false)
                  .fetchData(userController.user.peternakanId),
              Provider.of<WeatherController>(context, listen: false)
                  .fetchData(),
              Provider.of<ChickenPriceController>(context, listen: false)
                  .fetchData(),
            ],
          ),
        );
  }

  final List<Widget> _page = const [
    DashBoard(),
    AddData(),
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
    return Scaffold(
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.orange, size: 60),
              );
            }
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    _page[_selectedPage],
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CustomNavbar(
                        changePage: changePage,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
