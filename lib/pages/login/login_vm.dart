import 'package:flutter/foundation.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:framework/logger.dart';

class AccountDataViewModel extends ChangeNotifier {
  AccountDataViewModel();

  final _list = _initState();

  List<PCLocalAccount> get list => _list;

  static List<PCLocalAccount> _initState() {
    final initial = accountManager.values.toList();
    if (initial.isEmpty) {
      return initial;
    }
    final main = accountManager.current;
    if (main == null) {
      logger.w('', 'Accounts is not empty, but main account is null.');
      accountManager.setMainAccount(initial.first);
    } else {
      initial.removeWhere((element) => element.id == main.id);
      initial.insert(0, main);
    }
    return initial;
  }

  void increment(PCLocalAccount account) {
    _list.add(account);
    if (_list.length == 1) {
      // main account
      accountManager.setMainAccount(account);
    }
    accountManager.put(account);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final newState = _list;
    final account = newState.removeAt(oldIndex);
    newState.insert(newIndex, account);

    if (newIndex == 0) {
      // the first
      accountManager.setMainAccount(account);
    }
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
    if (index == 0) {
      // main account
      accountManager.setMainAccount(_list.first);
    }
    accountManager.delete(key: account.id);
    notifyListeners();
  }
}
