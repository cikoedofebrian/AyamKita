import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

Future<void> customDialog(
    BuildContext context, String title, String content) async {
  final completer = Completer<void>();
  NDialog(
          dialogStyle: DialogStyle(titleDivider: true),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                child: const Text(
                  "Tutup",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  completer.complete();
                }),
          ],
          content: Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(content)))
      .show(context);
  return completer.future;
}
