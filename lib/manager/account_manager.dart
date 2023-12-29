import 'dart:convert';

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/mock/anonymous_account.dart';
import 'package:pivot_chat/mock/api_available.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:framework/logger.dart';

final accountManager = PCAccountManager._();
const _tag = 'ACCOUNT';

abstract mixin class UserListener {
  void selfInfoUpdated(PCLocalAccount user) {}

  void userStatusChanged(UserStatusInfo info) {}
}

class PCAccountManager extends OnUserListener with TokenGetter {
  PCAccountManager._() {
    logger.i(_tag, 'init');
    if (apiAvailable) {
      OpenIM.iMManager.userManager.setUserListener(this);
    } else if (current == null && others.isEmpty) {
      add(kAnonymousAccount);
    }
  }

  static const _othersDataKey = "pc_account_others";
  static const _currentDataKey = "pc_account_current";

  final _listeners = <UserListener>{};

  void addListener(UserListener listener) {
    _listeners.add(listener);
  }

  void removeListener(UserListener listener) {
    _listeners.remove(listener);
  }

  @override
  void selfInfoUpdated(UserInfo info) {
    // update userinfo
    final cur = current;
    if (cur != null) {
      current = cur.copyWith(userinfo: info);
      for (var i in _listeners) {
        i.selfInfoUpdated(cur);
      }
    } else {
      logger.w(_tag, 'selfInfoUpdated, but no account');
    }
  }

  @override
  void userStatusChanged(UserStatusInfo info) {
    // TODO: implement userStatusChanged

    for (var i in _listeners) {
      i.userStatusChanged(info);
    }
  }

  PCLocalAccount? get current {
    final json = spManager.getVal<String>(_currentDataKey);
    if (json == null) return null;
    return PCLocalAccount.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  set current(PCLocalAccount? account) {
    spManager.setVal(_currentDataKey, jsonEncode(account));
  }

  // 将当前account从others里删除，并添加到current里，
  // 如果current不为空，则将current添加到others里
  void changeCurrent(PCLocalAccount account) {
    final cur = current;
    if (cur != null && cur.key == account.key) {
      logger.d(_tag, 'Change current $PCLocalAccount: $account, already current');
      return;
    }

    final others = this.others.toList();
    final index = others.indexWhere((element) => element.key == account.key);
    if (index == -1) {
      logger.w(_tag, 'Change current $PCLocalAccount: $account, not found');
      return;
    }
    others.removeAt(index);

    if (cur != null) {
      others.add(cur);
    }
    this.others = others;
    current = account;
    logger.i(_tag, 'Change over. Current: $account, others: $others');
  }

  bool isCurrent(PCLocalAccount account) {
    return current?.key == account.key;
  }

  Iterable<PCLocalAccount> get others {
    final String? json = spManager.getVal(_othersDataKey);
    return _json2accounts(json) ?? [];
  }

  set others(Iterable<PCLocalAccount>? accounts) => spManager.setVal(_othersDataKey, jsonEncode(accounts));

  Iterable<PCLocalAccount>? get all {
    final cur = current;
    if (cur == null) return others;
    return [cur, ...others];
  }

  Stream<Iterable<PCLocalAccount>> get othersStream =>
      spManager.watch(key: _othersDataKey).map((event) => _json2accounts(event.value as String?) ?? []);

  Stream<PCLocalAccount?> get currentStream => spManager.watch(key: _currentDataKey).map((event) =>
      event.value == null ? null : PCLocalAccount.fromJson(jsonDecode(event.value as String) as Map<String, dynamic>));

  @override
  String? getToken() {
    return current?.token;
  }

  void add(PCLocalAccount account) {
    logger.i(_tag, 'Add $PCLocalAccount: $account');
    final accounts = others.toList();
    assert(accounts.indexWhere((element) => element.key == account.key) == -1, 'Account already exists');
    accounts.add(account);
    others = accounts;
  }

  void delete({required String key}) {
    logger.i(_tag, 'Remove $PCLocalAccount by key: $key');
    if (key == current?.key) {
      logger.w(_tag, 'Remove current account');
      spManager.setVal(_currentDataKey, null);
      return;
    }
    final accounts = others.toList();
    final index = accounts.indexWhere((element) => element.key == key);
    if (index == -1) {
      logger.w(_tag, 'Remove $PCLocalAccount by key: $key, not found');
      return;
    }
    accounts.removeAt(index);
    others = accounts;
  }
}

Iterable<PCLocalAccount>? _json2accounts(String? json) {
  if (null == json) return null;
  final list = jsonDecode(json);
  if (list is! List<dynamic>) {
    return null;
  }
  if (list.firstOrNull is! Map<String, dynamic>) {
    return null;
  }
  return list.map((e) => PCLocalAccount.fromJson(e as Map<String, dynamic>));
}
