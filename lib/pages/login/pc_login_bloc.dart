import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:utils/logger.dart';

class PCLoginSourceBloc extends Cubit<List<PCLocalAccount>> {
  static List<PCLocalAccount> _initState() {
    final initial = accountManager.getAll().toList();
    if (initial.isEmpty) {
      return initial;
    }
    final main = accountManager.current;
    if (main == null) {
      logger.w('Accounts is not empty, but main account is null.');
      accountManager.setMainAccount(initial.first);
    } else {
      initial.removeWhere((element) => element.id == main.id);
      initial.insert(0, main);
    }
    return initial;
  }

  PCLoginSourceBloc() : super(_initState());

  void increment(PCLocalAccount account) {
    final newState = state + [account];
    assert(newState.length == state.length + 1 && newState != state);
    if (newState.length == 1) {
      // main account
      accountManager.setMainAccount(account);
    }
    accountManager.put(account);
    emit(newState);
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final newState = state.toList();
    final account = newState.removeAt(oldIndex);
    newState.insert(newIndex, account);

    assert(newState.length == state.length && newState != state);

    if (newIndex == 0) {
      // the first
      accountManager.setMainAccount(account);
    }
    emit(newState);
  }

  void decrement(PCLocalAccount account) {
    assert(state.isNotEmpty);
    final newState = state.toList();
    newState.remove(account);
    if (account == state.first) {
      // main account
      accountManager.setMainAccount(newState.first);
    }
    assert(newState.length == state.length - 1 && newState != state);
    accountManager.remove(account.id);
    emit(newState);
  }
}
