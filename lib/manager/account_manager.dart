import 'package:hive/hive.dart';
import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import 'package:pivot_chat/manager/sp_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:utils/logger.dart';

final accountManager = PCAccountManager._();

class PCAccountManager with TokenGetter, PCBaseBoxManager<int, PCLocalAccount> {
  PCAccountManager._() {
    logger.i('AccountManager init');
  }

  static const _dataKeyIdName = "pc_account_id";

  Iterable<PCLocalAccount> get _accounts => getAll();

  PCLocalAccount? get current => get(_currentId);

  int? get _currentId => spManager.getVal(_dataKeyIdName);

  set _currentId(int? index) => spManager.setVal(_dataKeyIdName, index);

  Stream<BoxEvent> get currentIdStream => spManager.watch(_dataKeyIdName);

  Stream<BoxEvent> get currentAccountsStream => watch();

  void setMainAccount(PCLocalAccount account) async {
    logger.i('SetMainAccount:$account');
    final accounts = _accounts;
    assert(accounts.isNotEmpty);
    if (accounts.any((element) => element.id == account.id)) {
      _currentId = account.id;
    } else {
      put(account);
      _currentId = account.id;
      logger.w('SetMainAccount:Account not exist, add it first.');
    }
  }

  @override
  String? getToken() {
    return current?.token;
  }
}
