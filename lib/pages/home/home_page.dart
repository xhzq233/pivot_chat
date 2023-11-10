import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:pivot_chat/pages/add_contact/add_contact_page.dart';
import 'package:pivot_chat/pages/todo_list/todo_page.dart';
import 'package:pivot_chat/view_model/account_view_model.dart';
import 'package:pivot_chat/view_model/conversations_view_model.dart';
import 'package:pivot_chat/widgets/conversation/conversation_widget.dart';
import 'package:provider/provider.dart';
import 'package:framework/cupertino.dart';

import 'home_vm.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route(PCLocalAccount account) {
    return CupertinoPageRoute(
      builder: (_) => Provider(
        create: (context) => HomeViewModel(),
        child: Provider(
          create: (_) => ConversationsViewModel(),
          child: ChangeNotifierProvider(
            create: (ctx) => AccountViewModel(userID: account.key),
            child: const HomePage(key: ValueKey('HomePage')),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Home', style: TextStyle(color: CupertinoColors.label.resolveFrom(context))),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => (),
              child: const Icon(CupertinoIcons.person_alt_circle),
            ),
            trailing: Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push(TodoListPage.route()),
                  child: const Text('Example'),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.push(context, AddContactPage.route()),
                  child: const Icon(CupertinoIcons.add),
                ),
              ],
            ),
          ),
        ],
        body: Stack(
          children: [
            BaseList(
              itemBuilder: ConversationWidget.itemBuilder,
              viewModel: context.read<ConversationsViewModel>(),
              primary: true,
              topSliver: SliverToBoxAdapter(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CupertinoColors.systemGrey3.resolveFrom(context),
                  ),
                  child: NavigationLink(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: vm.addRandomAccount,
                    child: const Row(
                      children: [
                        Text('Add Random account'),
                        Spacer(),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
