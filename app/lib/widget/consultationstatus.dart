import 'package:app/constant/requeststatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';

class ConsultationStatus extends StatelessWidget {
  const ConsultationStatus(
      {super.key, required this.status, required this.hasilId});
  final String status;
  final String hasilId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: status == RequestStatus.selesai
              ? const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 5)
              : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.green),
          child: Row(
            children: [
              Text(
                status.capitalize(),
                style: const TextStyle(color: Colors.white),
              ),
              if (status == RequestStatus.selesai)
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed('/result-view', arguments: hasilId),
                      child: Row(
                        children: const [
                          Text(
                            'Hasil',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                            child: Icon(
                              Icons.navigate_next_rounded,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
