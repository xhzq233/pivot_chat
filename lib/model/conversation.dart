/// pivot_chat - conversation
/// Created by xhz on 11/16/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';

class Conversation extends BaseItemModel<String> {
  final ConversationInfo _conversationInfo;

  const Conversation(this._conversationInfo);

  @override
  String get key => _conversationInfo.conversationID;

  bool get isPinned => _conversationInfo.isPinned == true;
}
