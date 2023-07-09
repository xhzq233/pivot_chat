import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/pages/dev/bloc/pc_dev_counter_cubit.dart';
import 'package:pivot_chat/route.dart';
import 'package:pivot_chat/theme.dart';

class PCApp extends StatelessWidget {
  const PCApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // top-level providers, accessible to all routes
      providers: [
        if (kDebugMode) BlocProvider(create: (context) => PCCounterCubit()),
      ],
      child: MaterialApp.router(
        theme: lightThemeData,
        title: 'Pivot Chat',
        routerConfig: route,
        // 统一为 iOS 风格的滑动效果
        scrollBehavior: const CupertinoScrollBehavior(),
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
