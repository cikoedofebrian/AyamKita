import 'package:flutter/material.dart';

class HalfOvalBottomNavBar extends StatefulWidget {
  @override
  _HalfOvalBottomNavBarState createState() => _HalfOvalBottomNavBarState();
}

class _HalfOvalBottomNavBarState extends State<HalfOvalBottomNavBar> {
  int _currentIndex = 0;

  List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _icons.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = entry.key;
              });
            },
            child: CustomPaint(
              painter: HalfOvalPainter(
                color: _currentIndex == entry.key
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              child: Container(
                height: 70,
                width: 70,
                child: Icon(
                  entry.value,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class HalfOvalPainter extends CustomPainter {
  final Color color;

  HalfOvalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2 - 25, 0)
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2, 25)
      ..arcToPoint(
        Offset(size.width / 2 + 25, 25),
        radius: Radius.circular(25),
        clockwise: false,
      )
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2 - 25, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HalfOvalPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
