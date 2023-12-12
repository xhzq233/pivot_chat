import 'dart:convert';

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:framework/logger.dart';

final accountManager = PCAccountManager._();
const _tag = 'ACCOUNT';

class PCAccountManager extends OnUserListener with TokenGetter {
  PCAccountManager._() {
    logger.i(_tag, 'init');
    OpenIM.iMManager.userManager.setUserListener(this);
  }

  static const _dataKeyIdName = "pc_accounts";

  final _listeners = <OnUserListener>{};

  void addListener(OnUserListener listener) {
    _listeners.add(listener);
  }

  void removeListener(OnUserListener listener) {
    _listeners.remove(listener);
  }

  @override
  void selfInfoUpdated(UserInfo info) {
    // update userinfo
    final copy = accounts?.toList(growable: false);
    if (copy != null && copy.isNotEmpty) {
      copy[0] = copy.first.copyWith(userinfo: info);
      accounts = copy;
    }

    for (var i in _listeners) {
      i.selfInfoUpdated(info);
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
    return accounts?.firstOrNull;
  }

  Iterable<PCLocalAccount>? get accounts {
    final String? json = spManager.getVal(_dataKeyIdName);
    return _json2accounts(json);
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

  set accounts(Iterable<PCLocalAccount>? accounts) => spManager.setVal(_dataKeyIdName, jsonEncode(accounts));

  Stream<Iterable<PCLocalAccount>> get accountsStream =>
      spManager.watch(key: _dataKeyIdName).map((event) => _json2accounts(event.value as String?) ?? []);

  @override
  String? getToken() {
    return current?.token;
  }

  void add(PCLocalAccount account) {
    logger.i(_tag, 'Add $PCLocalAccount: $account');
    final accounts = this.accounts?.toList() ?? [];
    assert(accounts.indexWhere((element) => element.key == account.key) == -1, 'Account already exists');
    accounts.add(account);
    this.accounts = accounts;
  }

  void replace(PCLocalAccount account) {
    logger.i(_tag, 'Put $PCLocalAccount: $account');
    final accounts = this.accounts?.toList() ?? [];
    final index = accounts.indexWhere((element) => element.key == account.key);
    if (index == -1) {
      logger.w(_tag, 'Replace $PCLocalAccount: $account, not found');
      return;
    }
    accounts[index] = account;
    this.accounts = accounts;
  }

  void delete({required String key}) {
    logger.i(_tag, 'Remove $PCLocalAccount by key: $key');
    final accounts = this.accounts?.toList() ?? [];
    final index = accounts.indexWhere((element) => element.key == key);
    if (index == -1) {
      logger.w(_tag, 'Remove $PCLocalAccount by key: $key, not found');
      return;
    }
    accounts.removeAt(index);
    this.accounts = accounts;
  }
}
