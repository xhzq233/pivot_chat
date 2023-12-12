/// pivot_chat - person_modal
/// Created by xhz on 12/11/23

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:pivot_chat/pages/add_contact/add_contact_page.dart';
import 'package:pivot_chat/pages/todo_list/todo_page.dart';
import 'package:pivot_chat/view_model/account_view_model.dart';
import 'package:pivot_chat/widgets/image/pc_network_image.dart';
import 'package:provider/provider.dart';

import '../../../im.dart';

class PersonModal extends StatelessWidget {
  const PersonModal({super.key});

  static void show(BuildContext context, [PCLocalAccount? account]) {
    final PCLocalAccount account_ = account ?? PCLocalAccount.anonymous;
    showCupertinoModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider(
        create: (ctx) => AccountViewModel(userID: account_.key),
        child: const PersonModal(key: ValueKey('HomePage')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final person = context.watch<AccountViewModel>().user;
    // TODO: need a ViewModel for listening the changes of accounts.
    final accounts = accountManager.others;
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(person.name),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: PCNetworkImage(imageUrl: person.userinfo.faceURL ?? '', fit: BoxFit.cover),
            ),
            actions: [
              CupertinoButton(
                onPressed: () => Navigator.push(context, AddContactPage.route()),
                child: const Icon(CupertinoIcons.add),
              ),
              CupertinoButton(
                onPressed: () => Navigator.push(context, TodoListPage.route()),
                child: const Icon(CupertinoIcons.checkmark_alt),
              ),
            ],
          ),
          // Others' account
          const SliverToBoxAdapter(
            child: ListTile(
              title: Text('Others'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final account = accounts?.elementAtOrNull(index);
                if (account == null) {
                  return null;
                }
                return ListTile(
                  title: Text(account.name),
                  leading: CircleAvatar(
                    child: PCNetworkImage(imageUrl: account.userinfo.faceURL ?? ''),
                  ),
                  onTap: () async {
                    SmartDialog.showLoading();
                    await logoutIM();
                    accountManager.changeCurrent(account);
                    await loginIM();

                    SmartDialog.dismiss();
                  },
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(CupertinoIcons.power),
              selected: true,
              onTap: logoutIM,
            ),
          ),
        ],
      ),
    );
  }
}
