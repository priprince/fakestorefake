import 'package:flutter/material.dart' show Colors;
import 'package:fluttertoast/fluttertoast.dart'
    show Fluttertoast, Toast, ToastGravity;

class CommonWidgets {
  static showToast(
    String message, {
    ToastGravity? toastGravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 12,
    );
  }
}
