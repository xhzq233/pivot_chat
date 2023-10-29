import 'package:framework/list.dart';

const _kMyId = 0;

class MessageModel extends BaseItemModel<int> {
  const MessageModel({required this.content, required this.key, required this.sender});

  final String content;

  final int sender;

  @override
  final int key;

  bool get mine => sender == _kMyId;
}
