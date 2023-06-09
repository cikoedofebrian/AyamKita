import 'package:app/constant/app_color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isContinue = false;
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      if (pageController.page! > 0.5 && isContinue == false) {
        setState(() {
          isContinue = true;
        });
      } else if (pageController.page! <= 0.5 && isContinue == true) {
        setState(() {
          isContinue = false;
        });
      }
    });
    super.initState();
  }

  void navigateToNextPage() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: size * 0.7,
          child: PageView(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              children: [
                getSplashContent('assets/images/splash_screen_image1.png',
                    'Solusi ternak ayam cerdas !!!', context),
                getSplashContent(
                    'assets/images/splash_screen_image2.png',
                    'Karena dengan peternakan yang baik dapat menciptakan daging yang berkualitas',
                    context),
              ]),
        ),
        Container(
          height: size * 0.3,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          alignment: isContinue ? Alignment.center : Alignment.centerRight,
          child: InkWell(
            onTap: isContinue
                ? () => Navigator.of(context).pushReplacementNamed('/login')
                : () => navigateToNextPage(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: isContinue
                  ? const Text(
                      'MULAI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget getSplashContent(
      String imageAsset, String text, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Image.asset(imageAsset),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 80,
            child: Image.asset("assets/images/splash_screen_title.png"),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
