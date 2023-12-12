import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';
import 'package:framework/logger.dart';

// (1 同意/-1 拒绝/0 未处理)
enum FriendApplicationStatus {
  agree,
  reject,
  unhandled;

  int get value {
    switch (this) {
      case FriendApplicationStatus.agree:
        return 1;
      case FriendApplicationStatus.reject:
        return -1;
      case FriendApplicationStatus.unhandled:
        return 0;
    }
  }

  static FriendApplicationStatus fromValue(int value) {
    switch (value) {
      case 1:
        return FriendApplicationStatus.agree;
      case -1:
        return FriendApplicationStatus.reject;
      case 0:
        return FriendApplicationStatus.unhandled;
      default:
        throw ArgumentError.value(value, 'value', 'Invalid value');
    }
  }

  String get text {
    switch (this) {
      case FriendApplicationStatus.agree:
        return 'Agreed';
      case FriendApplicationStatus.reject:
        return 'Rejected';
      case FriendApplicationStatus.unhandled:
        return 'Unhandled';
    }
  }
}

class FriendApplicationModel extends BaseItemModel<String> {
  const FriendApplicationModel(this._info);

  final FriendApplicationInfo _info;

  @override
  String get key => _info.fromUserID! + _info.toUserID!;

  String get fromUserID => _info.fromUserID!;

  String get toUserID => _info.toUserID!;

  String get fromUserNickName => _info.fromNickname!;

  String get toUserNickName => _info.toNickname!;

  String get faceUrl => _info.fromFaceURL ?? '';

  String get addWording {
    if (_info.reqMsg == null || _info.reqMsg!.isEmpty) {
      return 'Add me as a friend';
    } else {
      return _info.reqMsg!;
    }
  }

  DateTime get addTime => DateTime.fromMillisecondsSinceEpoch(_info.createTime!);

  FriendApplicationStatus get status => FriendApplicationStatus.fromValue(_info.handleResult!);
}

// API: https://doc.rentsoft.cn/zh-Hans/sdks/api/friend/getFriendApplicationListAsRecipient
class ApplicationsViewModel with BaseListViewModel<FriendApplicationModel, String> {
  ApplicationsViewModel() {
    _refresh();
  }

  @override
  final List<FriendApplicationModel> list = [];

  Future<void> _refresh() async {
    try {
      final list = await OpenIM.iMManager.friendshipManager.getFriendApplicationListAsRecipient();
      replaceList(list.map((e) => FriendApplicationModel(e)).toList());
    } catch (e, stack) {
      logger.e('IM', 'getFriendApplicationListAsRecipient error', e, stack);
    }
  }

  // TODO(低优先级): 添加handleMsg, reject同
  // TODO(考验): 为每个accept和reject的按钮添加loading防止重复点击
  Future<void> accept(FriendApplicationModel info) async {
    await OpenIM.iMManager.friendshipManager.acceptFriendApplication(userID: info.fromUserID);
    await _refresh();
  }

  Future<void> reject(FriendApplicationModel info) async {
    await OpenIM.iMManager.friendshipManager.refuseFriendApplication(userID: info.fromUserID);
    await _refresh();
  }
}
