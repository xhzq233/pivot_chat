import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/list.dart';
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
        return Provider(
          create: (ctx) => TodoDataViewModel(),
          dispose: (ctx, vm) => vm.dispose(),
          child: ChangeNotifierProvider(
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Todo List')),
      child: Material(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const TodoListView(),
            inputFieldVM.buildWith(child: const _InputFieldView()),
          ],
        ),
      ),
    );
  }
}

class _InputFieldView extends StatelessWidget {
  const _InputFieldView();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: const HomeIndicatorPadding(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: _InputFieldBody(),
        ),
      ),
    );
  }
}

class _InputFieldBody extends StatelessWidget {
  const _InputFieldBody();

  @override
  Widget build(BuildContext context) {
    // Watch the state changes.
    final TodoInputFieldViewModel inputFieldVM = context.watch();

    final state = inputFieldVM.state;

    final isKeyboard = state is KeyboardInputFieldState;
    final void Function() press;
    final Widget icon;
    if (isKeyboard) {
      press = inputFieldVM.lock;
      icon = const Icon(Icons.lock_rounded);
    } else {
      press = inputFieldVM.unlock;
      icon = const Icon(Icons.lock_open_rounded);
    }
    final btn = IconButton(onPressed: press, icon: icon);

    if (isKeyboard) {
      return TextField(
        controller: state.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffix: ListenableBuilder(
            listenable: state,
            builder: (BuildContext context, Widget? child) {
              return ElevatedButton(
                onPressed: state.submitEnabled ? state.finalizeEditing : null,
                child: const Text('Add'),
              );
            },
          ),
          suffixIcon: btn,
        ),
      );
    } else if (state is LockInputFieldState) {
      return InputDecorator(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: btn,
        ),
        child: Text(state.text ?? ''),
      );
    }
    throw UnimplementedError();
  }
}
