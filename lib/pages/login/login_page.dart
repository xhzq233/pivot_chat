import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_vm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(
      builder: (_) => ChangeNotifierProvider(
        create: (context) => AccountDataViewModel(),
        child: const LoginPage(key: ValueKey('LoginPage')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          middle: Text('Accounts', style: TextStyle(color: CupertinoColors.label.resolveFrom(context)))),
      body: const _LoginAccountsWidget(),
    );
  }
}

class _LoginAccountsWidget extends StatelessWidget {
  const _LoginAccountsWidget();

  @override
  Widget build(BuildContext context) {
    final AccountDataViewModel vm = context.watch();
    return ReorderableListView.builder(
      onReorder: vm.reorder,
      itemCount: vm.list.length,
      itemBuilder: (context, index) {
        final item = vm.list[index];
        if (index == 0) {
          // big avatar
          return ListTile(
            key: ValueKey(item),
            title: Text(item.name),
            subtitle: Text(item.email),
            leading: CircleAvatar(
              child: Text(item.name.substring(0, 1)),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => vm.decrement(item),
            ),
            onTap: () => vm.press(item, context),
            selected: true,
          );
        }
        return ListTile(
          key: ValueKey(item),
          title: Text(item.name),
          subtitle: Text(item.email),
          leading: CircleAvatar(
            child: Text(item.name.substring(0, 1)),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => vm.decrement(item),
          ),
          onTap: () => vm.press(item, context),
        );
      },
    );
  }
}
