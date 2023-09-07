import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/pages/dev/dev_page.dart';
import 'package:pivot_chat/theme.dart';

class PCApp extends StatelessWidget {
  const PCApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      title: 'Pivot Chat',
      // 统一为 iOS 风格的滑动效果
      scrollBehavior: const CupertinoScrollBehavior(),
      builder: FlutterSmartDialog.init(),
      onGenerateRoute: (RouteSettings setting) => DevPage.route(),
    );
  }
}
