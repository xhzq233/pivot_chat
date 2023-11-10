/// pivot_chat - convesation_widget
/// Created by xhz on 11/10/23

import 'package:flutter/widgets.dart';
import 'package:pivot_chat/view_model/conversations_view_model.dart';

// TODO: 会话列表的单个Widget
class ConversationWidget extends StatelessWidget {
  const ConversationWidget({super.key});

  static Widget itemBuilder(Conversation conversation, int index) {
    return const ConversationWidget();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
