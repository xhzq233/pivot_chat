/// pivot_chat - person_modal
/// Created by xhz on 12/11/23

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:pivot_chat/pages/add_contact/add_contact_page.dart';
import 'package:pivot_chat/pages/todo_list/todo_page.dart';
import 'package:pivot_chat/view_model/account_view_model.dart';
import 'package:pivot_chat/view_model/conversation_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../login/login_page.dart';

class PersonModal extends StatelessWidget {
  const PersonModal({super.key});

  static void show(BuildContext context, [PCLocalAccount? account]) {
    final PCLocalAccount account_ = account ?? PCLocalAccount.anonymous;
    showCupertinoModalBottomSheet(
      context: context,
      builder: (_) => Provider.value(
        value: account_,
        child: Provider(
          create: (_) => ConversationListViewModel(),
          dispose: (_, vm) => vm.dispose(),
          child: ChangeNotifierProvider(
            create: (ctx) => AccountViewModel(userID: account_.key),
            child: const PersonModal(key: ValueKey('HomePage')),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final person = context.read<PCLocalAccount>();
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(person.name),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                person.userinfo.faceURL ?? 'https://blog.xhzq.xyz/images/avatar.jpeg',
                fit: BoxFit.cover,
              ),
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
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: const Text('Account'),
                subtitle: Text(person.key),
                leading: CircleAvatar(
                    child: person.userinfo.faceURL == null
                        ? Text(person.name.substring(0, 1))
                        : Image.network(person.userinfo.faceURL!)),
              ),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(CupertinoIcons.power),
                onTap: () async {
                  await OpenIM.iMManager.logout();
                  navigator?.pushAndRemoveUntil(LoginPage.route(), (Route<dynamic> route) => false);
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
