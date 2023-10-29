import 'package:flutter/material.dart';
import 'package:framework/list.dart';
import 'package:provider/provider.dart';

import 'todo_list_input_field.dart';
import 'todo_list_vm.dart';
import 'todo_model.dart';
import 'todo_page.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key, required this.index, required this.todo});

  static Widget itemBuilder(Todo messageModel, int index) {
    return TodoWidget(index: index, todo: messageModel);
  }

  final int index;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.key),
      onDismissed: (_) {
        context.read<TodoDataViewModel>().delete(todo.key);
      },
      direction: DismissDirection.endToStart,
      background: const ColoredBox(color: Colors.red),
      child: ListTile(
        title: Text(todo.content),
        onTap: () => Navigator.push(context, TodoPage.route(todo)),
        trailing: Checkbox(
          value: todo.done,
          onChanged: (bool? value) {
            context.read<TodoDataViewModel>().update(todo.copyWith(done: value));
          },
        ),
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseList<TodoDataViewModel, Todo, String>(
      itemBuilder: TodoWidget.itemBuilder,
      viewModel: context.read<TodoDataViewModel>(),
      bottomSliver: SliverToBoxAdapter(
        child: context.read<TodoInputFieldViewModel>().inputHeightBox,
      ),
      reverse: true,
    );
  }
}
