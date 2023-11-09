import 'dart:math';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class HomeViewModel {
  void addRandomAccount() {
    final name = Random().nextInt(100000).toString();

    SmartDialog.showToast('Added account($name)');
  }
}
