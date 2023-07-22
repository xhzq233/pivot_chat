import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pivot_chat/app.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:utils/logger.dart';
import 'package:utils/platform.dart';

void main() async {
  // ensure the platform services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // here runs the services which must be initialized before runApp
  setStatusBar(Brightness.dark);
  await Hive.initFlutter();
  Hive.registerAdapter(PCLocalAccountAdapter());

  final futures = <Future<void>>[accountManager.init(), spManager.init()];
  await Future.wait(futures);

  // here runs the app
  logger.i('main.dart - main() - runApp');
  runApp(const PCApp());
}
