import 'package:app/constant/app_color.dart';
import 'package:app/widget/custom_back_button.dart';
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
