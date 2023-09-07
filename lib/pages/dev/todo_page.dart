import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base.dart';
import 'package:provider/provider.dart';

import 'todo_list_input_field.dart';
import 'todo_list_view.dart';
import 'todo_list_vm.dart';
import 'todo_model.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.todo});

  static Route<void> route(Todo todo) {
    return CupertinoPageRoute(
      builder: (_) => TodoPage(todo: todo),
    );
  }

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: Align(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: FittedBox(child: Text(todo.content)),
        ),
      ),
    );
  }
}

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute(
      maintainState: false,
      builder: (_) {
        return DisposableProvider(
          create: (ctx) => TodoDataViewModel(),
          child: DisposableProvider(
            create: (ctx) => TodoInputFieldViewModel(ctx.read<TodoDataViewModel>()),
            child: const TodoListPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TodoInputFieldViewModel inputFieldVM = context.read();
    return Scaffold(
      appBar: const CupertinoNavigationBar(middle: Text('Todo List')),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const TodoListView(),
          inputFieldVM.build(
            decorationBuilder: (child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
