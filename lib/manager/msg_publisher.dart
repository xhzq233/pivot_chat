/// pivot_chat - msg_publisher
/// Created by xhz on 11/9/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';

import '../model/message_model.dart';

final messagePublisher = MessagePublisher._();

mixin MessageReceiver {
  // conversationID	String	会话 ID
  String get conversationID;

  void onMessageReceived(MessageModel message);

  void onMessageDeleted(MessageModel messageModel);
}

class MessagePublisher extends OnAdvancedMsgListener {
  MessagePublisher._();

  final Map<String, MessageReceiver> _receivers = {};

  void addReceiver(MessageReceiver receiver) {
    _receivers[receiver.conversationID] = receiver;
  }

  void removeReceiver(MessageReceiver receiver) {
    _receivers.remove(receiver.conversationID);
  }

  // TODO: Publish message to receivers
  @override
  void msgDeleted(Message msg) {
    final wrapped = MessageModel(msg);
    _receivers[wrapped.conversationID]?.onMessageDeleted(wrapped);
  }

  /// 消息被撤回
  @override
  void newRecvMessageRevoked(RevokedInfo info) {}

  /// C2C消息已读回执
  @override
  void recvC2CReadReceipt(List<ReadReceiptInfo> list) {}

  ///  群消息已读回执
  @override
  void recvGroupReadReceipt(List<ReadReceiptInfo> list) {}

  /// 收到扩展消息被删除
  /// [list] 被删除的TypeKey
  @override
  void recvMessageExtensionsDeleted(String msgID, List<String> list) {}

  /// 收到了一条新消息
  @override
  void recvNewMessage(Message msg) {}

  @override
  void recvOfflineNewMessage(Message msg) {}
}
