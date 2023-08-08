import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/group_manager.dart';
import 'package:pivot_chat/manager/message_manager.dart';
import 'package:pivot_chat/pages/dev/pc_dev_counter_bloc.dart';
import 'package:pivot_chat/pages/dev/pc_dev_page.dart';
import 'package:pivot_chat/pages/home/pc_home_page.dart';
import 'package:pivot_chat/pages/login/pc_login_bloc.dart';
import 'package:pivot_chat/pages/login/pc_login_page.dart';

Future<String?> _redirectCheck(BuildContext context, GoRouterState state) async {
  if (accountManager.isEmpty) {
    return '/login';
  }
  await messageManager.init();
  await groupManager.init();
  return null;
}

final route = GoRouter(
  initialLocation: '/dev/${Random().nextInt(100)}',
  observers: [
    FlutterSmartDialog.observer,
  ],
  routes: [
    GoRoute(
      path: '/dev/:count',
      builder: (context, state) => BlocProvider(
        create: (context) => PCDevBloc(initial: int.tryParse(state.pathParameters['count'] ?? '0')),
        child: const PCDevPage(title: 'dev'),
      ),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => PCHomePage(),
      redirect: _redirectCheck,
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PCLoginSourceBloc()),
        ],
        child: const PCLoginPage(),
      ),
    ),
  ],
);
