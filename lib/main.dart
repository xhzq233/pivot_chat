import 'package:flutter/material.dart';
import 'package:pivot_chat/app.dart';
import 'package:pivot_chat/util/pc_logger.dart';
import 'package:pivot_chat/util/platform/set_status_bar.dart';

void main() {
  // ensure the platform services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // here runs the services which must be initialized before runApp
  setStatusBar(Brightness.dark);

  // here runs the app
  logger.i('main.dart - main() - runApp');
  runApp(const PCApp());
}
