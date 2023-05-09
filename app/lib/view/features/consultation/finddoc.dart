import 'package:app/constant/appcolor.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FindDoctor extends StatefulWidget {
  const FindDoctor({super.key});

  @override
  State<FindDoctor> createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final findDoctorController = Provider.of<FindDoctorController>(context);
    print(findDoctorController.isLoading);
    if (findDoctorController.isLoading == true) {
      findDoctorController.fetchData();
    }

    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => findDoctorController.refreshData(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: findDoctorController.isLoading
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: AppColor.secondary, size: 60),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => Container(
                        child: Text(
                            findDoctorController.list[index].harga.toString()),
                      ),
                      itemCount: findDoctorController.list.length,
                    ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print(findDoctorController.isLoading);
              },
              child: Text('sss')),
          const CustomBackButton(
            color: AppColor.secondary,
          )
        ],
      ),
    );
  }
}
