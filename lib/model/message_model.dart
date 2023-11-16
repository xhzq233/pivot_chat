import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/account_manager.dart';

class MessageModel extends BaseItemModel<String> {
  @override
  String get key => _message.clientMsgID!;

  bool get mine => _message.sendID == accountManager.current?.key;

  final Message _message;

  const MessageModel(this._message);

  String? get textContent {
    if (_message.contentType == MessageType.text) {
      assert(_message.textElem != null);
      return _message.textElem?.content;
    }
    return _message.textElem?.content;
  }

  PictureElem? get imageContent {
    if (_message.contentType == MessageType.picture) {
      assert(_message.pictureElem != null);
      return _message.pictureElem;
    }
    return _message.pictureElem;
  }

  // TODO: 解析剩余消息类型(https://doc.rentsoft.cn/zh-Hans/sdks/enum/messageContentType)

  String get fallbackContent {
    switch (_message.contentType) {
      case MessageType.text:
        return _message.textElem?.content ?? "文本消息解析失败";
      case MessageType.picture:
        return "[图片]";
      default:
        return "暂不支持的消息类型";
    }
  }
}
