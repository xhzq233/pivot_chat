/// pivot_chat - account_view_model
/// Created by xhz on 11/9/23
import 'package:flutter/foundation.dart';

/// 放在顶层是因为很多地方需要使用，需要扩大作用域。
/// TODO: 监听每个用户状态的变化，比如用户的在线、信息等。
/// 比如自身状态的更新
/// API(https://doc.rentsoft.cn/zh-Hans/sdks/listener/userListener)
class AccountViewModel extends ChangeNotifier {
  final String userID;

  // 指定监听的用户ID
  AccountViewModel({required this.userID});
}
