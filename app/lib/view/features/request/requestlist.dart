import 'package:app/constant/appcolor.dart';
import 'package:app/constant/role.dart';
import 'package:app/controller/consultationrequest.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:app/widget/requestwidget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    final requestController =
        Provider.of<ConsultationRequestController>(context);
    final peternakanId =
        Provider.of<UserController>(context, listen: false).user.peternakanId;
    if (requestController.isLoading) {
      requestController.fetchData(peternakanId);
    }
    final isOnSelecting = ModalRoute.of(context)!.settings.arguments as bool;
    final list =
        isOnSelecting ? requestController.acceptedList : requestController.list;
    final isPengelola =
        Provider.of<UserController>(context, listen: false).user.role ==
            UserRole.pengelola;

    return RefreshIndicator(
      onRefresh: () => requestController.fetchData(peternakanId),
      child: Scaffold(
        floatingActionButton: isPengelola
            ? Container(
                padding: const EdgeInsets.all(12),
                child: FloatingActionButton.extended(
                    label: const Text(
                      'Tambah',
                      style: TextStyle(
                          color: AppColor.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: AppColor.tertiary,
                    icon: const Icon(
                      Icons.add,
                      color: AppColor.secondary,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/request')),
              )
            : null,
        body: requestController.isLoading == true
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.orange, size: 60),
              )
            : Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                color: AppColor.secondary,
                                height: 130,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 105, top: 25),
                                  child: Text(
                                    'Usulan Konsultasi',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              const CustomBackButton(
                                  color: AppColor.quaternary),
                            ],
                          ),
                        ),
                        Expanded(
                          child: list.isNotEmpty
                              ? ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  itemBuilder: (context, index) =>
                                      RequestWidget(
                                    isOnSelected: isOnSelecting,
                                    data: list[index],
                                  ),
                                  itemCount: list.length,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Belum ada usulan konsultasi',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Klik tambah untuk menambahkan usulan konsultasi baru',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  if (requestController.isSelected.isNotEmpty)
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, '/select-payment'),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.tertiary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'LANJUT KE PEMBAYARAN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
