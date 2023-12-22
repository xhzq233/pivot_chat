import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/image/pc_network_image.dart';
import '../new_account/new_account_page.dart';
import 'login_vm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route({bool logout = false}) {
    return CupertinoPageRoute<void>(
      builder: (_) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(logout: logout),
        child: const LoginPage(key: ValueKey('LoginPage')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Accounts', style: TextStyle(color: CupertinoColors.label.resolveFrom(context))),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.push(context, NewAccountPage.route()),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      body: const _LoginAccountsWidget(),
    );
  }
}

class _LoginAccountsWidget extends StatelessWidget {
  const _LoginAccountsWidget();

  @override
  Widget build(BuildContext context) {
    final LoginViewModel vm = context.watch();
    return ReorderableListView.builder(
      onReorder: vm.reorder,
      itemCount: vm.list.length,
      itemBuilder: (context, index) {
        final item = vm.list[index];
        return ListTile(
          key: ValueKey(item.key),
          title: Text(item.name),
          leading: CircleAvatar(child: PCNetworkImage(imageUrl: item.userinfo.faceURL ?? '')),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => vm.decrement(item),
          ),
          onTap: () => LoginViewModel.login(item),
          selected: index == 0,
        );
      },
    );
  }
}
