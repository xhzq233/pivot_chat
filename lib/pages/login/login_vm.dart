import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:framework/logger.dart';

import '../../im.dart';

class LoginViewModel extends ChangeNotifier with BaseListViewModel<PCLocalAccount, String> {
  LoginViewModel({bool logout = false}) {
    final cur = accountManager.current;
    if (cur != null && cur.autologin == true && !logout) {
      logger.i('', 'autologin with ${cur.toJson()}');
      press(cur);
      return;
    }
    accountManager.currentStream.listen((event) {
      if (event == null) {
        return;
      }
      assert(() {
        final none = accountManager.others?.toList().indexWhere((t) => t.key == event.key) == -1;
        assert(none, 'current account should not in others');
        return true;
      }());

      if (_list.isEmpty) {
        _list.add(event);
      } else {
        _list[0] = event;
      }

      notifyListeners();
    });
    accountManager.othersStream.listen((event) {
      final cur = accountManager.current;
      _list.clear();
      _list.addAll(event);
      if (cur != null) {
        _list.insert(0, cur);
      }
      notifyListeners();
    });
  }

  final _list = accountManager.all?.toList() ?? [];

  @override
  List<PCLocalAccount> get list => _list;

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final newState = _list;
    final account = newState.removeAt(oldIndex);
    newState.insert(newIndex, account);
    accountManager.others = newState;
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

  void press(PCLocalAccount account) async {
    accountManager.changeCurrent(account);
    if (account.rememberPasswd == false) {
      SmartDialog.showToast('Goto passwd page');
      return;
    }
    SmartDialog.showLoading(msg: 'Login...');
    await loginIM();
    SmartDialog.dismiss();
  }
}
