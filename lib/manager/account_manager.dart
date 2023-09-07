import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:framework/logger.dart';

final accountManager = PCAccountManager._();
const _tag = 'ACCOUNT';

class PCAccountManager with TokenGetter, PCBaseBoxManager<int, PCLocalAccount> {
  PCAccountManager._() {
    logger.i(_tag, 'init');
  }

  static const _dataKeyIdName = "pc_account_id";

  PCLocalAccount? get current {
    final id = _currentId;
    if (id == null) return null;
    return get(id);
  }

  int? get _currentId => spManager.getVal(_dataKeyIdName);

  set _currentId(int? index) => spManager.setVal(_dataKeyIdName, index);

  Stream<int> get currentIdStream => spManager.watch(key: _dataKeyIdName).map((event) => event.value as int);

  Stream<PCLocalAccount> get currentAccountsStream => watch().map((event) => event.value as PCLocalAccount);

  void setMainAccount(PCLocalAccount account) async {
    logger.i(_tag, 'SetMainAccount:$account');
    final accounts = values;
    assert(accounts.isNotEmpty);
    if (accounts.any((element) => element.id == account.id)) {
      _currentId = account.id;
    } else {
      put(account);
      _currentId = account.id;
      logger.w(_tag, 'SetMainAccount:Account not exist, add it first.');
    }
  }

  @override
  String? getToken() {
    return current?.token;
  }
}
