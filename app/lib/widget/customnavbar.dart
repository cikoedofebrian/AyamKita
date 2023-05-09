import 'package:app/constant/role.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/navbarbgpainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({
    super.key,
    required this.changePage,
    required this.index,
  });

  final Function(int index) changePage;
  final int index;

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  // int widget.index = 0;
  @override
  Widget build(BuildContext context) {
    // print('${widget.index} index');
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
                    widget.changePage(0);
                  },
                  child: Image.asset(
                    widget.index == 0
                        ? "assets/navbar_icon/home_enabled.png"
                        : "assets/navbar_icon/home.png",
                  ),
                ),
              ).animate(target: widget.index == 0 ? 1 : 0).shake(),
              if (Provider.of<UserController>(context, listen: false)
                      .user
                      .role !=
                  UserRole.dokter)
                SizedBox(
                  height: 50,
                  width: 22,
                  child: InkWell(
                    onTap: () {
                      widget.changePage(1);
                    },
                    child: Image.asset(widget.index == 1
                        ? "assets/navbar_icon/data_enabled.png"
                        : "assets/navbar_icon/data.png"),
                  ),
                ).animate(target: widget.index == 1 ? 1 : 0).shake(),
              Container(
                height: 50,
                width: 22,
                margin: const EdgeInsets.only(top: 10),
                child: InkWell(
                    onTap: () {
                      widget.changePage(2);
                    },
                    child: Image.asset(widget.index == 2
                        ? "assets/navbar_icon/profile_enabled.png"
                        : "assets/navbar_icon/profile.png")),
              ).animate(target: widget.index == 2 ? 1 : 0).shake(),
            ],
          ),
        ),
      ],
    );
  }
}
