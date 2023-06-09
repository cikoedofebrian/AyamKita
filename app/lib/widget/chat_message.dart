import 'package:app/constant/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
      required this.message,
      required this.sender,
      this.receiverUrl,
      required this.isOtherReply,
      this.timestamp});
  final String message;
  final bool sender;
  final String? receiverUrl;
  final bool isOtherReply;
  final Timestamp? timestamp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (sender == false)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: isOtherReply
                      ? CircleAvatar(
                          backgroundImage: receiverUrl!.isNotEmpty
                              ? NetworkImage(
                                  receiverUrl!,
                                )
                              : const AssetImage("assets/images/profile.png")
                                  as ImageProvider)
                      : const CircleAvatar(
                          backgroundColor: Colors.transparent,
                        ),
                ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: 10,
                      left: sender ? 50 : 10,
                      right: sender ? 10 : 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2.2),
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ],
                    color: sender
                        ? const Color.fromRGBO(255, 212, 176, 1)
                        : Colors.white,
                    border: Border.all(color: AppColor.formborder, width: 2),
                    borderRadius: BorderRadius.only(
                      topLeft: sender ? const Radius.circular(20) : Radius.zero,
                      topRight: const Radius.circular(20),
                      bottomLeft: const Radius.circular(20),
                      bottomRight:
                          sender ? Radius.zero : const Radius.circular(20),
                    ),
                  ),
                  child: Text(message),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
