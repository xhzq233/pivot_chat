// import 'dart:math';
import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
// import 'package:pivot_chat/manager/account_manager.dart';
// import 'package:pivot_chat/manager/group_manager.dart';
// import 'package:pivot_chat/manager/message_manager.dart';
// import 'package:pivot_chat/pages/dev/pc_dev_counter_bloc.dart';
// import 'package:pivot_chat/pages/dev/pc_dev_page.dart';
import 'package:pivot_chat/pages/home/pc_home_page.dart';
import 'package:pivot_chat/pages/login/pc_login_page.dart';
import 'package:pivot_chat/pages/start/pc_start_page.dart';
// import 'package:pivot_chat/pages/login/pc_login_bloc.dart';
// import 'package:pivot_chat/pages/login/pc_login_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        //return WelcomeScreen();
        return PCHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'loging',
          builder: (BuildContext context, GoRouterState state) {
            return LogingPage();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return PCHomePage();
          },
        ),
      ],
    ),
  ],
);
