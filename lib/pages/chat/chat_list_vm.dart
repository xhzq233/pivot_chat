import 'package:framework/base.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/msg_publisher.dart';

import '../../model/message_model.dart';

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
  void onMessageDeleted(MessageModel messageModel) {
    // TODO: implement onMessageDeleted
  }

  @override
  void onMessageReceived(MessageModel message) {
    // TODO: implement onMessageReceived
  }
}
