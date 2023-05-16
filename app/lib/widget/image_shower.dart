import 'package:app/constant/appcolor.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageShower extends StatelessWidget {
  const ImageShower({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Stack(children: [
      PhotoView(imageProvider: NetworkImage(downloadUrl)),
      const CustomBackButton(color: AppColor.secondary),
    ]);
  }
}
