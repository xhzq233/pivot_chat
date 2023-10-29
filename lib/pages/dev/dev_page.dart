import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/pages/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:framework/cupertino.dart';

import '../todo_list/todo_list_view.dart';
import '../todo_list/todo_list_vm.dart';
import '../todo_list/todo_model.dart';
import '../todo_list/todo_page.dart';
import 'dev_vm.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => Provider(
        create: (context) => DevViewModel(),
        child: Provider(
          create: (ctx) => TodoDataViewModel(),
          dispose: (ctx, vm) => vm.dispose(),
          child: const DevPage(key: ValueKey('LoginPage')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<DevViewModel>();

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Dev', style: TextStyle(color: CupertinoColors.label.resolveFrom(context))),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).push(LoginPage.route()),
              child: const Text('Login'),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).push(TodoListPage.route()),
              child: const Text('Todo Example'),
            ),
          ),
        ],
        body: Stack(
          children: [
            BaseList<TodoDataViewModel, Todo, String>(
              itemBuilder: TodoWidget.itemBuilder,
              viewModel: context.read<TodoDataViewModel>(),
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
