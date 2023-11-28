import 'package:flutter/material.dart';

class R {
  static sh(double height, BuildContext context) {
    return MediaQuery.sizeOf(context).height * (height / 812);
  }

  static sw(double width, BuildContext context) {
    return MediaQuery.sizeOf(context).width * (width / 375);
  }
}
