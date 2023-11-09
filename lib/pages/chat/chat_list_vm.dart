import 'package:framework/list.dart';

import 'message_model.dart';

// TODO: 消息逻辑。
class ChatListDataViewModel with BaseListViewModel<MessageModel, int> {
  final List<MessageModel> _list = [
    const MessageModel(content: 'content', key: 1, sender: 1),
    const MessageModel(content: 'content', key: 2, sender: 0),
  ];

  @override
  List<MessageModel> get list => _list;
}
