import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:framework/logger.dart';

import '../../im.dart';
import '../home/home_page.dart';

class LoginViewModel extends ChangeNotifier with BaseListViewModel<PCLocalAccount, String> {
  LoginViewModel(BuildContext context) {
    if (accountManager.current?.autologin == true) {
      logger.i('', 'autologin with ${accountManager.current?.toJson()}');
      press(accountManager.current!, context);
      return;
    }
    accountManager.accountsStream.listen((event) {
      _list.clear();
      _list.addAll(event);
      notifyListeners();
    });
  }

  final _list = accountManager.accounts?.toList() ?? [];

  @override
  List<PCLocalAccount> get list => _list;

  void increment(PCLocalAccount account) {
    _list.add(account);
    accountManager.add(account);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final newState = _list;
    final account = newState.removeAt(oldIndex);
    newState.insert(newIndex, account);
    accountManager.accounts = newState;
    notifyListeners();
  }

  void decrement(PCLocalAccount account) {
    assert(_list.isNotEmpty);
    final index = _list.indexWhere((element) => account == element);
    if (index == -1) {
      logger.w('', 'Account not found.');
      return;
    }
    _list.removeAt(index);
    accountManager.delete(key: account.key);
    notifyListeners();
  }

  void press(PCLocalAccount account, BuildContext context) async {
    if (account.rememberPasswd == false) {
      SmartDialog.showToast('Goto passwd page');
      return;
    }
    function() => Navigator.pushAndRemoveUntil(context, HomePage.route(account), (route) => false);
    SmartDialog.showLoading(msg: 'Login...');
    await loginIM();
    SmartDialog.dismiss();
    function();
  }
}
