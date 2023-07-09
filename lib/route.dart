import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:pivot_chat/pages/dev/pc_dev_page.dart';
import 'package:pivot_chat/pages/home/pc_home_page.dart';

final route = GoRouter(initialLocation: kDebugMode ? '/dev' : '/', observers: [
  FlutterSmartDialog.observer
], routes: [
  GoRoute(
    path: '/dev',
    builder: (context, state) => const PCDevPage(title: 'dev'),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const PCHomePage(),
  )
]);
