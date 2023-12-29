/// pivot_chat - conversations_view_model
/// Created by xhz on 11/10/23

import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/manager/conv_publisher.dart';
import 'package:pivot_chat/mock/api_available.dart';
import 'package:pivot_chat/model/conversation_model.dart';

/// 会话列表的ViewModel
/// TODO: 设置会话属性(置顶、Mute)
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
    if (!apiAvailable) return;

    replaceList((await OpenIM.iMManager.conversationManager.getAllConversationList())
        .map(
          (e) => ConversationModel(e),
        )
        .toList(growable: false));
    conversationPublisher.addListReceiver(this);
  }

  @override
  void conversationChanged(List<ConversationModel> list) {
    // list去重合并
    for (var newItem in list) {
      final index = this.list.indexWhere((e) => e.conversationID == newItem.conversationID);
      if (index == -1) {
        this.list.add(newItem);
      } else {
        this.list[index] = newItem;
      }
    }

    // 排序, 按照latestMsgSendTime降序排列
    this.list.sort((a, b) => b.latestMsgSendTime.compareTo(a.latestMsgSendTime));

    // 通知View更新
    notifyList();
  }
}
