import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/base.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/msg_publisher.dart';

import 'message_model.dart';

// TODO: 消息逻辑。
class ChatListDataViewModel with DisposeMixin, BaseListViewModel<MessageModel, String>, MessageReceiver {
  final List<MessageModel> _list = [];

  @override
  List<MessageModel> get list => _list;

  @override
  // TODO: implement conversationID
  String get conversationID => throw UnimplementedError();

  ChatListDataViewModel() {
    messagePublisher.addReceiver(this);
  }

  @override
  void dispose() {
    messagePublisher.removeReceiver(this);
  }

  @override
  void onMessageReceived(Message message) {
    // TODO: implement onMessageReceived
  }
}
