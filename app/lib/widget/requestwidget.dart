import 'package:app/constant/appcolor.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({super.key, required this.data});
  final ConsultationRequestModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/requestlist_bg.png"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '02-03-2004',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Text('Ayam menggigil')
            ],
          ),
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingAnimationWidget.fallingDot(
                    color: AppColor.tertiary, size: 30);
              }
              if (snapshot.data == null) {
                return const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    "assets/images/profile.png",
                  ),
                );
              }
              return CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(snapshot.data!),
              );
            },
            future: data.imageUrl(),
          ),
        ),
      ]),
    );
  }
}
