import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBar(Brightness brightness) {
  if (brightness == Brightness.dark) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
  }
}
