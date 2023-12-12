import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:pivot_chat/pages/home/person/person_modal.dart';
import 'package:pivot_chat/pages/todo_list/todo_page.dart';
import 'package:pivot_chat/view_model/account_view_model.dart';
import 'package:pivot_chat/view_model/conversation_list_view_model.dart';
import 'package:pivot_chat/widgets/conversation/conversation_widget.dart';
import 'package:provider/provider.dart';
import 'package:framework/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'home_vm.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route([PCLocalAccount? account]) {
    final PCLocalAccount account_ = account ?? PCLocalAccount.anonymous;
    return MaterialWithModalsPageRoute(
      builder: (_) => Provider(
        create: (context) => HomeViewModel(),
        child: Provider(
          create: (_) => ConversationListViewModel(),
          dispose: (_, vm) => vm.dispose(),
          child: ChangeNotifierProvider(
            create: (ctx) => AccountViewModel(userID: account_.key),
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
            largeTitle: const _Title(),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => PersonModal.show(context, context.read<AccountViewModel>().user),
              child: const Icon(CupertinoIcons.person_alt_circle),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push(TodoListPage.route()),
                  child: const Text('Example'),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: vm.toAddContact,
                  child: const Icon(CupertinoIcons.add),
                ),
              ],
            ),
          ),
        ],
        body: BaseList(
          itemBuilder: ConversationWidget.itemBuilder,
          viewModel: context.read<ConversationListViewModel>(),
          primary: true,
          topSliver: SliverToBoxAdapter(
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CupertinoColors.systemGrey5.resolveFrom(context),
              ),
              child: NavigationLink(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                pressedColor: CupertinoColors.systemGrey4,
                onPressed: vm.search,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.search, color: CupertinoColors.systemGrey.resolveFrom(context)),
                    const SizedBox(width: 8),
                    Text('Search',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: CupertinoColors.systemGrey.resolveFrom(context))),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    // 由于用CupertinoSliverNavigationBar会有Hero动画的问题，Overlay找不到对应Provider，所以需要AccountViewModel加上optional
    return Text(
      // 单独提出，缩减build范围
      context.watch<AccountViewModel?>()?.user.name ?? '',
      style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
    );
  }
}
