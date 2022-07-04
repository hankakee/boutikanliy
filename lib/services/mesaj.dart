import "package:flutter/material.dart";
import 'dart:async';

class ManagerMesaj {
  void showMesaj(context, mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaj)));
  }

  void showMesaj2(context, mesaj, bool hideclose, int time) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(mesaj),
        actions: <Widget>[
          hideclose
              ? TextButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  child: const Icon(Icons.close, color: Colors.red),
                )
              : const Text(""),
        ],
      ),
    );

    Timer(Duration(seconds: time), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }
}
