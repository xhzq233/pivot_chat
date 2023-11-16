/// pivot_chat - conv_publisher
/// Created by xhz on 11/16/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:pivot_chat/model/conversation.dart';

final conversationPublisher = ConversationPublisher._();

mixin ConversationReceiver {
  // conversationID	String	会话 ID
  String get conversationID;

  void onConvChanged(Conversation conv);
}

mixin ConversationListReceiver {
  void conversationChanged(List<Conversation> list);
}

class ConversationPublisher extends OnConversationListener {
  ConversationPublisher._();

  final Map<String, ConversationReceiver> _receivers = {};

  final Set<ConversationListReceiver> _listReceivers = {};

  void addReceiver(ConversationReceiver receiver) {
    _receivers[receiver.conversationID] = receiver;
  }

  void removeReceiver(ConversationReceiver receiver) {
    _receivers.remove(receiver.conversationID);
  }

  void addListReceiver(ConversationListReceiver receiver) {
    _listReceivers.add(receiver);
  }

  void removeListReceiver(ConversationListReceiver receiver) {
    _listReceivers.remove(receiver);
  }

  // TODO: Publish changes to receivers
  /// 会话发生改变
  @override
  void conversationChanged(List<ConversationInfo> list) {
    for (var conv in list) {
      _receivers[conv.conversationID]?.onConvChanged(Conversation(conv));
    }
    for (var element in _listReceivers) {
      element.conversationChanged(list.map((e) => Conversation(e)).toList());
    }
  }

  /// 有新会话产生
  @override
  void newConversation(List<ConversationInfo> list) {
    for (var element in _listReceivers) {
      element.conversationChanged(list.map((e) => Conversation(e)).toList());
    }
  }

  /// 未读消息总数发送改变
  @override
  void totalUnreadMessageCountChanged(int i) {}

  @override
  void syncServerFailed() {}

  @override
  void syncServerFinish() {}

  @override
  void syncServerStart() {}
}
