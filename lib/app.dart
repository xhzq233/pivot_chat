import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/theme.dart';

//无context跳转的GlobalKey配置
GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

NavigatorState? get navigator => _navigatorKey.currentState;

class PCApp extends StatelessWidget {
  const PCApp({super.key});

  static late final Route<void> startRoute;

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
      onGenerateRoute: (RouteSettings setting) => startRoute,
      //navigatorKey配置
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      // checkerboardOffscreenLayers: true,
      // checkerboardRasterCacheImages: true,
    );
  }
}
