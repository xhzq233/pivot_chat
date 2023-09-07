import 'package:flutter/material.dart';
import 'package:framework/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pivot_chat/app.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/model/account.dart';

void main() async {
  runApp(const _PreLaunch());
}

Future<void> _preLaunch() async {
  // Run splash screen.
  logger.i('main.dart', 'runSplash');

  // Here runs the services which must be initialized before app.
  await Hive.initFlutter();
  Hive.registerAdapter(PCLocalAccountAdapter());

  final futures = <Future<void>>[accountManager.init(), spManager.init()];
  await Future.wait(futures);
}

class _PreLaunch extends StatefulWidget {
  const _PreLaunch();

  @override
  State<_PreLaunch> createState() => _PreLaunchState();
}

class _PreLaunchState extends State<_PreLaunch> {
  @override
  void initState() {
    super.initState();
    _preLaunch().then((_) => setState(() => _canLaunch = true));
  }

  bool _canLaunch = false;

  @override
  Widget build(BuildContext context) {
    if (!_canLaunch) {
      final platformBrightness = View.of(context).platformDispatcher.platformBrightness;
      final color = platformBrightness == Brightness.light ? Colors.white : Colors.black;
      return ColoredBox(
        color: color,
        child: Align(
          child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('assets/icon/icon.png')),
        ),
      );
    } else {
      logger.i('main.dart', 'runApp');
      // Here runs the app.
      return const PCApp();
    }
  }
}
