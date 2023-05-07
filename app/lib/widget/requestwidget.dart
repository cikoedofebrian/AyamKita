import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
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
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Material(
                  color: data.getColor(),
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      data.status.capitalize(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                    child: LoadingAnimationWidget.threeRotatingDots(
                        color: AppColor.tertiary, size: 30),
                  );
                }
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: snapshot.data!.downloadUrl.isEmpty
                          ? const AssetImage("assets/images/profile.png")
                          : NetworkImage(snapshot.data!.downloadUrl)
                              as ImageProvider,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text('sss'),
                    Text(
                      snapshot.data!.nama.split(' ')[0],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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
