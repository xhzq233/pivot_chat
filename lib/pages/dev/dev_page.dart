import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base.dart';
import 'package:framework/list.dart';
import 'package:pivot_chat/pages/dev/todo_list_input_field.dart';
import 'package:pivot_chat/pages/dev/todo_page.dart';
import 'package:pivot_chat/pages/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:framework/cupertino.dart';

import 'dev_vm.dart';
import 'todo_list_view.dart';
import 'todo_list_vm.dart';
import 'todo_model.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => Provider(
        create: (context) => DevViewModel(),
        child: DisposableProvider(
          create: (ctx) => TodoDataViewModel(),
          child: DisposableProvider(
            create: (ctx) => TodoInputFieldViewModel(ctx.read<TodoDataViewModel>()),
            child: const DevPage(key: ValueKey('LoginPage')),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<DevViewModel>();
    final inputVM = context.read<TodoInputFieldViewModel>();

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Dev'),
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
              bottomSliver: SliverToBoxAdapter(child: context.read<TodoInputFieldViewModel>().inputHeightBox),
              topSliver: SliverToBoxAdapter(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CupertinoColors.systemGrey3,
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
            inputVM.build(
              decorationBuilder: (child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
