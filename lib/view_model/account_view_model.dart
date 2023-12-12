/// pivot_chat - account_view_model
/// Created by xhz on 11/9/23
import 'package:flutter/foundation.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:pivot_chat/manager/account_manager.dart';

/// 放在顶层是因为很多地方需要使用，需要扩大作用域。
/// TODO: 监听每个用户状态的变化，比如用户的在线、信息等。
/// 比如自身状态的更新
/// API(https://doc.rentsoft.cn/zh-Hans/sdks/listener/userListener)
class AccountViewModel extends OnUserListener with ChangeNotifier {
  final String userID;

  UserInfo? userInfo;

  // 指定监听的用户ID，目前应该只有自己..
  AccountViewModel({required this.userID}) {
    accountManager.addListener(this);
  }

  @override
  void dispose() {
    super.dispose();
    accountManager.removeListener(this);
  }

  @override
  void selfInfoUpdated(UserInfo info) {
    userInfo = info;
    notifyListeners();
  }

  @override
  void userStatusChanged(UserStatusInfo info) {
    // TODO: implement userStatusChanged
    notifyListeners();
  }
}
