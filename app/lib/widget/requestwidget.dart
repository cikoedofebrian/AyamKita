import 'package:app/constant/appcolor.dart';
import 'package:app/constant/appformat.dart';
import 'package:app/controller/consultationrequest.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget(
      {super.key, required this.data, required this.isOnSelected});
  final ConsultationRequestModel data;
  final bool isOnSelected;

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  late Future future;

  @override
  void initState() {
    future = widget.data.imageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSelected = Provider.of<ConsultationRequestController>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          border: Border.all(
              color:
                  currentSelected.isSelected == widget.data.usulanKonsultasiId
                      ? AppColor.tertiary
                      : Colors.transparent,
              width: 5),
          image: const DecorationImage(
              image: AssetImage("assets/images/requestlist_bg.png"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => widget.isOnSelected
            ? currentSelected.selectRequest(widget.data.usulanKonsultasiId)
            : Navigator.pushNamed(context, '/request-details',
                arguments: widget.data),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppFormat.dDate(widget.data.tanggal),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Text(
                  widget.data.judul,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Material(
                  color: widget.data.getColor(),
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      widget.data.status.capitalize(),
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
                          : CachedNetworkImage(
                                  imageUrl: snapshot.data!.downloadUrl)
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
              future: future,
            ),
          ),
        ]),
      ),
    );
  }
}
