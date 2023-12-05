/// pivot_chat - conversations_view_model
/// Created by xhz on 11/10/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/conv_publisher.dart';
import 'package:pivot_chat/model/conversation_model.dart';

/// 会话列表的ViewModel
/// TODO: 获取会话列表、设置会话属性
/// 例如用于Conversation展示会话列表页面（Home）
/// API文档(https://doc.rentsoft.cn/zh-Hans/sdks/api/conversation)
class ConversationListViewModel with BaseListViewModel<ConversationModel, String>, ConversationListReceiver {
  @override
  final List<ConversationModel> list = [];

  ConversationListViewModel() {
    _init();
  }

  void dispose() {
    conversationPublisher.removeListReceiver(this);
  }

  void _init() async {
    list.addAll(
      (await OpenIM.iMManager.conversationManager.getAllConversationList()).map(
        (e) => ConversationModel(e),
      ),
    );
    conversationPublisher.addListReceiver(this);
  }

  @override
  void conversationChanged(List<ConversationModel> list) {
    // TODO: implement conversationChanged
    // list去重合并排序，通知View更新
  }
}
