/// pivot_chat - anonymous_account
/// Created by xhz on 12/29/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:pivot_chat/model/account.dart';

final kAnonymousAccount = PCLocalAccount(
  userinfo: UserInfo(userID: 'anonymous', faceURL: "https://blog.xhzq.xyz/images/avatar.jpeg", nickname: "anonymous"),
  rememberPasswd: true,
  autologin: true,
);
