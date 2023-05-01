import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({super.key, required this.data});
  final ConsultationRequestModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/requestlist_bg.png"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, '/request-details', arguments: data),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppFormat.dDate(data.tanggal),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Text(
                  data.judul,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            width: 120,
            padding: const EdgeInsets.only(left: 20),
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: LoadingAnimationWidget.fallingDot(
                        color: AppColor.tertiary, size: 30),
                  );
                }
                if (snapshot.data!.downloadUrl.isEmpty) {
                  return const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  );
                }
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(snapshot.data!.downloadUrl),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.nama.split(' ')[0],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                );
              },
              future: data.imageUrl(),
            ),
          ),
        ]),
      ),
    );
  }
}
