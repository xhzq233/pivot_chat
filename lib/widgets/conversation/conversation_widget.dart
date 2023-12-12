/// pivot_chat - convesation_widget
/// Created by xhz on 11/10/23

import 'package:flutter/material.dart';
import 'package:pivot_chat/model/conversation_model.dart';
import 'package:pivot_chat/widgets/image/pc_network_image.dart';

// TODO: 会话列表的单个Widget
class ConversationWidget extends StatelessWidget {
  const ConversationWidget({super.key, required this.conversation});

  final ConversationModel conversation;

  static Widget itemBuilder(ConversationModel conversation, int index) {
    return ConversationWidget(conversation: conversation);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: PCNetworkImage(imageUrl: conversation.avatar),
      ),
      title: Text(conversation.name),
      subtitle: Text(conversation.latestMsgData),
      trailing: Text(conversation.timeFormatted),
    );
  }
}
