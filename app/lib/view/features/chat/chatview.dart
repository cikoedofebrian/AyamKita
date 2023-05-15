import 'dart:isolate';

import 'package:app/constant/appcolor.dart';
import 'package:app/controller/consultationcontroller.dart';
import 'package:app/model/usermodel.dart';
import 'package:app/widget/chatmessage.dart';
import 'package:app/widget/custombackbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final chatController = TextEditingController();
  final scrollController = ScrollController();
  String sender = "";
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });

    super.initState();
  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final consultationController = Provider.of<ConsultationController>(context);
    final receiver = ModalRoute.of(context)!.settings.arguments as UserModel;

    Future<void> trySend() async {
      if (chatController.text.isNotEmpty) {
        await consultationController.sendNewChat(chatController.text);
      }
      scrollDown();
    }

    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Theme(
      data: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        ),
      ),
      child: Scaffold(
        body: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: AppColor.secondary, size: 60),
              );
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                    top: 160,
                                    left: 8,
                                    right: 8,
                                    bottom: 20,
                                  ),
                                  controller: scrollController,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    bool isOtherReply = false;
                                    if (snapshot.data!.docs[index]['sender']
                                            as String !=
                                        sender) {
                                      sender =
                                          snapshot.data!.docs[index]['sender'];
                                      isOtherReply = true;
                                    }
                                    return ChatMessage(
                                      sender: snapshot.data!.docs[index]
                                                  ['sender'] ==
                                              userId
                                          ? true
                                          : false,
                                      message: snapshot.data!.docs[index]
                                          ['pesan'],
                                      receiverUrl: receiver.downloadUrl,
                                      isOtherReply: isOtherReply,
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(2, 2.2),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  )
                                ],
                                border: Border.all(
                                    width: 1, color: AppColor.formborder),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: 'Kirimkan pesan...'),
                                      controller: chatController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: AppColor.formborder),
                                        color: AppColor.tertiary,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 10),
                                    child: IconButton(
                                      onPressed: () async {
                                        await trySend();
                                      },
                                      icon: const Icon(Icons.send_rounded),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Material(
                  color: AppColor.secondary,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const CustomBackButton(color: AppColor.secondary),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, top: 50),
                            child: Row(
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(100),
                                  elevation: 4,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: AppColor.tertiary,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: receiver
                                              .downloadUrl.isEmpty
                                          ? const AssetImage(
                                              'assets/images/profile.png')
                                          : NetworkImage(receiver.downloadUrl)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        receiver.nama,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        receiver.role,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('timestamp')
              .where('konsultasiId',
                  isEqualTo: consultationController.currentSelectedChat)
              .snapshots(),
        ),
      ),
    );
  }
}
