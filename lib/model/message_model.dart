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

  // 语言消息
  SoundElem? get soundContent {
    if (_message.contentType == MessageType.voice) {
      assert(_message.soundElem != null);
      return _message.soundElem;
    }
    return _message.soundElem;
  }

  // 视频消息
  VideoElem? get videoContent {
    if (_message.contentType == MessageType.video) {
      assert(_message.videoElem != null);
      return _message.videoElem;
    }
    return _message.videoElem;
  }

  // 文件
  FileElem? get fileContent {
    if (_message.contentType == MessageType.file) {
      assert(_message.fileElem != null);
      return _message.fileElem;
    }
    return null;
  }

  //@消息
  AtTextElem? get atTextContent {
    if (_message.contentType == MessageType.text) {
      assert(_message.atTextElem != null);
      return _message.atTextElem;
    }
    return null;
  }

  //合并消息
  MergeElem? get mergeContent {
    if (_message.contentType == MessageType.merger) {
      assert(_message.mergeElem != null);
      return _message.mergeElem;
    }
    return null;
  }

  // 名片消息
  CardElem? get cardContent {
    if (_message.contentType == MessageType.card) {
      assert(_message.cardElem != null);
      return _message.cardElem;
    }
    return null;
  }

  // 位置消息
  LocationElem? get locationContent {
    if (_message.contentType == MessageType.location) {
      assert(_message.locationElem != null);
      return _message.locationElem;
    }
    return null;
  }

  // 自定义消息
  CustomElem? get customContent {
    if (_message.contentType == MessageType.custom) {
      assert(_message.customElem != null);
      return _message.customElem;
    }
    return null;
  }

  //撤回消息回执 ，找不到

  // 输入状态
  TypingElem? get typingContent {
    if (_message.contentType == MessageType.typing) {
      assert(_message.typingElem != null);
      return _message.typingElem;
    }
    return null;
  }

  //引用消息
  QuoteElem? get quoteContent {
    if (_message.contentType == MessageType.quote) {
      assert(_message.quoteElem != null);
      return _message.quoteElem;
    }
    return null;
  }

  // 表情消息
  FaceElem? get faceContent {
    if (_message.contentType == MessageType.customFace) {
      assert(_message.faceElem != null);
      return _message.faceElem;
    }
    return null;
  }

  String get fallbackContent {
    switch (_message.contentType) {
      case MessageType.text:
        return _message.textElem?.content ?? "文本消息解析失败";
      case MessageType.picture:
        return "[图片]";
      case MessageType.voice:
        return "[语音]";
      case MessageType.video:
        return "[视频]";
      case MessageType.file:
        return "[文件]";
      case MessageType.atText:
        return _message.atTextElem?.text ?? "@消息解析失败";
      case MessageType.merger:
        return "[合并消息]";
      case MessageType.card:
        return "[名片消息]";
      case MessageType.location:
        return "[位置消息]";
      case MessageType.custom:
        return "[自定义消息]";
      case MessageType.typing:
        return "[输入状态]";
      case MessageType.quote:
        return "[引用消息]";
      case MessageType.customFace:
        return "[表情消息]";
      default:
        return "暂不支持的消息类型";
    }
  }
}
