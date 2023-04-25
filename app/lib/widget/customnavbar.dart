import 'package:app/widget/navbarbgpainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key, required this.changePage});

  final Function(int index) changePage;

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            100,
          ),
          painter: NavbarBGPainter(),
        ),
        Container(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 22,
                  margin: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      _currentIndex = 0;
                      widget.changePage(0);
                    },
                    child: Image.asset(
                      _currentIndex == 0
                          ? "assets/navbar_icon/home_enabled.png"
                          : "assets/navbar_icon/home.png",
                    ),
                  ),
                ).animate(target: _currentIndex == 0 ? 1 : 0).shake(),
                SizedBox(
                  height: 50,
                  width: 22,
                  child: InkWell(
                    onTap: () {
                      _currentIndex = 1;
                      widget.changePage(1);
                    },
                    child: Image.asset(_currentIndex == 1
                        ? "assets/navbar_icon/data_enabled.png"
                        : "assets/navbar_icon/data.png"),
                  ),
                ).animate(target: _currentIndex == 1 ? 1 : 0).shake(),
                Container(
                  height: 50,
                  width: 22,
                  margin: const EdgeInsets.only(top: 10),
                  child: InkWell(
                      onTap: () {
                        _currentIndex = 2;
                        widget.changePage(2);
                      },
                      child: Image.asset(_currentIndex == 2
                          ? "assets/navbar_icon/profile_enabled.png"
                          : "assets/navbar_icon/profile.png")),
                ).animate(target: _currentIndex == 2 ? 1 : 0).shake(),
              ],
            )),
      ],
    );
  }
}
