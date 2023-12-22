/// pivot_chat - im
/// Created by xhz on 10/29/23

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:framework/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pivot_chat/manager/conv_publisher.dart';
import 'package:pivot_chat/manager/msg_publisher.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:pivot_chat/pages/home/home_page.dart';
import 'package:pivot_chat/pages/login/login_page.dart';

import 'app.dart';
import 'manager/account_manager.dart';

final _loginFuture = Completer<bool>();

Future<void> initIM() async {
  if (kIsWeb) return;
  if (!Platform.isIOS && !Platform.isAndroid) {
    return;
  }

  final success = await OpenIM.iMManager.initSDK(
    // platformID: Platform.isIOS ? IMPlatform.ios : IMPlatform.android,
    platformID: 1,
    // 平台，参照IMPlatform类,
    apiAddr: "http://xhzq233.tpddns.cn:10002",
    // SDK的API接口地址。
    wsAddr: "ws://xhzq233.tpddns.cn:10001",
    // SDK的web socket地址
    dataDir: (await getApplicationDocumentsDirectory()).path,
    // 数据存储路径。如：var apath =(await getApplicationDocumentsDirectory()).path
    objectStorage: 'minio',
    logFilePath: (await getApplicationDocumentsDirectory()).path,
    logLevel: 2,
    // 日志等级，默认值6
    listener: OnConnectListener(
      onConnectSuccess: () {
        // 已经成功连接到服务器
        _loginFuture.complete(true);
      },
      onConnecting: () {
        // 正在连接到服务器，适合在 UI 上展示“正在连接”状态。
      },
      onConnectFailed: (code, errorMsg) {
        // 连接服务器失败，可以提示用户当前网络连接不可用
        _loginFuture.completeError('IM连接失败');
      },
      onUserTokenExpired: () {
        // 登录凭证已经过期，请重新登录。
        SmartDialog.showToast('IM登录凭证已经过期，请重新登录');
        navigator?.pushAndRemoveUntil(LoginPage.route(), (Route<dynamic> route) => false);
      },
      onKickedOffline: () {
        // 当前用户被踢下线，此时可以 UI
        // 提示用户“您已经在其他端登录了当前账号，是否重新登录？”
        SmartDialog.showToast('IM当前用户被踢下线');
        navigator?.pushAndRemoveUntil(LoginPage.route(), (Route<dynamic> route) => false);
      },
    ),
  ) as bool;

  if (!success) exit(-1);
}

bool _login = false;

Future<Route<void>> loginIM(PCLocalAccount account) async {
  if (_login) {
    throw "";
  }
  // Set listener
  OpenIM.iMManager
    // ..userManager.setUserListener(OnUserListener())
    ..messageManager.setAdvancedMsgListener(messagePublisher)
    // Set up message sending progress listener
    ..messageManager.setMsgSendProgressListener(OnMsgSendProgressListener())
    // ..messageManager.setCustomBusinessListener(OnCustomBusinessListener())
    // Set up friend relationship listener
    ..friendshipManager.setFriendshipListener(OnFriendshipListener())
    // Set up conversation listener
    ..conversationManager.setConversationListener(conversationPublisher)
    // Set up group listener
    ..groupManager.setGroupListener(OnGroupListener());
  accountManager.changeCurrent(account);
  SmartDialog.showLoading(msg: 'Login...');
  try {
    final info = await OpenIM.iMManager.login(userID: account.key, token: account.token!);
    accountManager.selfInfoUpdated(info);

    await _loginFuture.future;

    SmartDialog.dismiss(status: SmartStatus.loading);
    _login = true;
    return HomePage.route(account);
  } catch (e) {
    SmartDialog.dismiss(status: SmartStatus.loading);
    logger.e('IM', 'login error', e);
    SmartDialog.showToast('IM登录失败');
    return LoginPage.route();
  }
}

Future<void> logoutIM() async {
  navigator?.pushAndRemoveUntil(LoginPage.route(logout: true), (Route<dynamic> route) => false);
  await OpenIM.iMManager.logout();
  _login = false;
}
