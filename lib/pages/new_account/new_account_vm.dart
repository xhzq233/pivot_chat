import 'package:flutter/widgets.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:framework/logger.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/network/pc_network_manager.dart';
import 'package:pivot_chat/model/account.dart';

import '../../model/openim_spec_network.dart';

class NewAccountViewModel with ChangeNotifier {
  NewAccountViewModel();

  final TextEditingController controller = TextEditingController();
  final TextEditingController passwdController = TextEditingController();

  bool remember = false;

  bool auto = false;

  void rememberPassword(bool value) {
    remember = value;
    notifyListeners();
  }

  void autoLogin(bool value) {
    auto = value;
    notifyListeners();
  }

  void login(Function pop) async {
    final id = controller.text;
    if (id.isEmpty) {
      SmartDialog.showToast('ID cannot be empty');
      return;
    }
    final OpenIMBaseResp<OpenIMTokenResp>? resp = await netWorkManager.getToken(id);

    if (!resp.check()) return;

    String token;

    if (resp!.code == 1101) {
      logger.i('NEW ACCOUNT', 'login: ID($id) not exist');
      // TODO: 登陆页面加上选择nickname的文本框, Add faceURL
      final resp = await netWorkManager.register(uid: id);
      if (!resp.check()) return;
      login(pop);
    } else {
      if (resp.data == null) {
        logger.e('NEW ACCOUNT', 'login: data is null');
        return;
      }
      token = resp.data!.token;
      logger.i('NEW ACCOUNT', 'login: token($token)');
      accountManager.add(
        PCLocalAccount(
          userinfo: UserInfo(userID: id),
          token: token,
          rememberPasswd: remember,
          autologin: auto,
        ),
      );
      SmartDialog.showToast('Add success');
      pop();
    }
  }
}
