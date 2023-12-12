import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';
import 'package:framework/logger.dart';

// TODO: 除了好友还有群聊
class ContactModel extends BaseItemModel<String> {
  const ContactModel(this._info);

  final FriendInfo _info;

  @override
  String get key => _info.userID!;
}

class ContactsViewModel with BaseListViewModel<ContactModel, String> {
  ContactsViewModel() {
    _refresh();
  }

  @override
  final List<ContactModel> list = [];

  Future<void> _refresh() async {
    try {
      final list = await OpenIM.iMManager.friendshipManager.getFriendList();
      replaceList(list.map((e) => ContactModel(e)).toList());
    } catch (e) {
      logger.e('IM', 'getFriendList error', e);
    }
  }
}
