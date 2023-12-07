/// pivot_chat - conversation
/// Created by xhz on 11/16/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';

class ConversationModel extends BaseItemModel<String> {
  final ConversationInfo _conversationInfo;

  const ConversationModel(this._conversationInfo);

  // FIXME: 写的太屎了，相当于把OpenIM的conversationID屏蔽了
  String get conversationID {
    return _conversationInfo.conversationType == ConversationType.single
        ? _conversationInfo.userID!
        : _conversationInfo.groupID!;
  }

  @override
  String get key => _conversationInfo.conversationID;

  bool get isPinned => _conversationInfo.isPinned == true;

  int get latestMsgSendTime => _conversationInfo.latestMsgSendTime ?? 0;
}
