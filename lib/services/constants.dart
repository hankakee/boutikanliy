import "package:flutter/material.dart";

class Constants {
  static final cardsColor = Colors.grey[300];
  static Color primaryAppColor = const Color(0XFF994CFC);
  static String formatTitle(String textDesc) {
    if (textDesc.length > 13) {
      return textDesc.substring(0, 13) + "...";
    }
    return textDesc;
  }
}
