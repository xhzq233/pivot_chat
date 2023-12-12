import 'package:flutter/foundation.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/app.dart';

import '../add_contact/add_contact_page.dart';

class HomeViewModel {
  void search() {
    // TODO: implement search
  }

  void toAddContact() {
    if (!kDebugMode) {
      navigator?.push(AddContactPage.route());
    } else {
      try {
        OpenIM.iMManager.friendshipManager.addFriend(userID: 'openIMAdmin');
        SmartDialog.showToast('Add openIMAdmin success');
      } catch (_) {
        SmartDialog.showToast('Add openIMAdmin failed');
      }
    }
  }
}
