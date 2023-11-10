/// pivot_chat - conversations_view_model
/// Created by xhz on 11/10/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';

class Conversation extends BaseItemModel<String> {
  final ConversationInfo _conversationInfo;

  const Conversation(this._conversationInfo);

  @override
  String get key => _conversationInfo.conversationID;
}

/// 会话列表的ViewModel
/// TODO: 获取会话列表、设置会话属性
/// (https://doc.rentsoft.cn/zh-Hans/sdks/api/conversation)
class ConversationsViewModel with BaseListViewModel<Conversation, String> {
  ConversationsViewModel();

  @override
  // TODO: implement list
  List<Conversation> get list => throw UnimplementedError();
}
