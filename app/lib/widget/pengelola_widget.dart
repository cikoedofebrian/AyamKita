import 'package:app/constant/app_color.dart';
import 'package:app/model/m_akun.dart';
import 'package:flutter/material.dart';

class PengelolaWidget extends StatelessWidget {
  const PengelolaWidget({super.key, required this.data});
  final MAkun data;

  @override
  Widget build(BuildContext context) {
    Future<MAkun> userData() async {
      return data;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/requestlist_bg.png"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed('/profile-dummy', arguments: userData()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.nama,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColor.secondary,
              backgroundImage: data.downloadUrl.isNotEmpty
                  ? NetworkImage(data.downloadUrl)
                  : const AssetImage('assets/images/profile.png')
                      as ImageProvider,
            ),
          ],
        ),
      ),
    );
  }
}
