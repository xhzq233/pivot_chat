/// pivot_chat - conversation
/// Created by xhz on 11/16/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';
import 'package:framework/util.dart';
import 'package:pivot_chat/model/message_model.dart';

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

  String get timeFormatted =>
      DateTime.fromMillisecondsSinceEpoch(latestMsgSendTime).toDescription(yesterday: 'Yesterday');

  String get latestMsgData {
    final latestMsg = _conversationInfo.latestMsg;
    if (latestMsg == null) return 'None';
    return MessageModel(latestMsg).fallbackContent;
  }

  String get name => _conversationInfo.showName ?? 'Unknown';

  String get avatar => _conversationInfo.faceURL ?? '';
}
