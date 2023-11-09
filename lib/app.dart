import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/pages/login/login_page.dart';
import 'package:pivot_chat/theme.dart';

class PCApp extends StatelessWidget {
  const PCApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      title: 'Pivot Chat',
      // 统一为 iOS 风格的滑动效果
      scrollBehavior: const CupertinoScrollBehavior(),
      builder: FlutterSmartDialog.init(),
      onGenerateRoute: (RouteSettings setting) => LoginPage.route(),
      debugShowCheckedModeBanner: false,
      // checkerboardOffscreenLayers: true,
      // checkerboardRasterCacheImages: true,
    );
  }
}
