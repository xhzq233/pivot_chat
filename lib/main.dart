import 'package:flutter/material.dart';
import 'package:framework/logger.dart';
import 'package:framework/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pivot_chat/app.dart';
import 'package:pivot_chat/im.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/model/account.dart';

void main() async {
  runApp(const PreLaunch(
    app: PCApp(),
    preLaunch: _preLaunch,
    splash: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Image(image: AssetImage('assets/icon/icon.png')),
    ),
  ));
}

Future<void> _preLaunch() async {
  // Run splash screen.
  logger.i('main.dart', 'runSplash');

  // Here runs the services which must be initialized before app.
  await Hive.initFlutter();
  Hive.registerAdapter(PCLocalAccountAdapter());
  Hive.registerAdapter(UserInfoAdapter());

  final futures = <Future<void>>[initIM(), spManager.init()];
  await Future.wait(futures);
}
