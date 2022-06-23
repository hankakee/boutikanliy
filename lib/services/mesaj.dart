import "package:flutter/material.dart";

class ManagerMesaj {
  void showMesaj(context, mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaj)));
  }

  void showMesaj2(context, mesaj) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(mesaj),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
