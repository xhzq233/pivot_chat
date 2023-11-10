import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/pages/chat/message_model.dart';
import 'package:provider/provider.dart';

import 'chat_input_field_vm.dart';
import 'chat_list_vm.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute(
      builder: (_) => Provider(
        create: (ctx) => ChatListDataViewModel(),
        child: ChangeNotifierProvider(
          create: (ctx) => ChatInputFieldViewModel(),
          child: const ChatPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ChatInputFieldViewModel inputFieldVM = context.read();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Todo List')),
      resizeToAvoidBottomInset: false,
      child: Material(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: BaseList(
                itemBuilder: _MessageWidget.itemBuilder,
                viewModel: context.read<ChatListDataViewModel>(),
                bottomSliver: SliverToBoxAdapter(
                  child: inputFieldVM.inputHeightBox,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                reverse: true,
              ),
            ),
            inputFieldVM.buildWith(child: const _InputFieldView()),
          ],
        ),
      ),
    );
  }
}

class _InputFieldView extends StatelessWidget {
  const _InputFieldView();

  @override
  Widget build(BuildContext context) {
    return BlurredInputField(
      maskColor: CupertinoColors.systemBackground.resolveFrom(context).withOpacity(0.24),
      child: const HomeIndicatorPadding(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CupertinoTextField(),
        ),
      ),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget({required this.index, required this.model});

  static Widget itemBuilder(MessageModel messageModel, int index) {
    return _MessageWidget(index: index, model: messageModel);
  }

  final int index;
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    final Color bbColor;
    final AlignmentGeometry alignment;
    if (model.mine) {
      bbColor = CupertinoColors.systemGreen.resolveFrom(context);
      alignment = Alignment.centerRight;
    } else {
      bbColor = CupertinoColors.secondarySystemFill.resolveFrom(context);
      alignment = Alignment.centerLeft;
    }

    return Dismissible(
      key: ValueKey(model.key),
      onDismissed: (_) {
        context.read<ChatListDataViewModel>().delete(model.key);
      },
      direction: DismissDirection.endToStart,
      background: const ColoredBox(color: Colors.red),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bbColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.fallbackContent),
            ),
          ),
        ),
      ),
    );
  }
}
