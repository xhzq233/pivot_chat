/// pivot_chat - conversation_view_model
/// Created by xhz on 11/16/23

import 'package:flutter/cupertino.dart';
import 'package:pivot_chat/manager/conv_publisher.dart';
import 'package:pivot_chat/model/conversation_model.dart';

// TODO: 会话的ViewModel，监听会话详情并发布
class ConversationViewModel extends ChangeNotifier with ConversationReceiver {
  @override
  // TODO: implement conversationID
  String get conversationID => throw UnimplementedError();

  @override
  void onConvChanged(ConversationModel conv) {
    // TODO: implement onConvChanged
  }
}
