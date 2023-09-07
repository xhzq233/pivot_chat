import 'dart:math';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/manager/base_box_manager.dart';

import '../../manager/account_manager.dart';
import '../../model/account.dart';

class DevViewModel {
  void addRandomAccount() {
    final name = Random().nextInt(100000).toString();
    accountManager.put(
      PCLocalAccount(
        name: name,
        id: Random().nextInt(1000),
        email: "$name's Email",
        rememberPasswd: 1,
      ),
    );
    SmartDialog.showToast('Added account($name)');
  }
}
