import 'package:flutter/material.dart';
import 'package:framework/list.dart';

import 'todo_model.dart';

class KeyboardInputFieldState extends ChangeNotifier with InputState {
  KeyboardInputFieldState({this.controller, this.focusNode}) {
    if (controller != null) {
      controller!.addListener(notifyListeners);
    }
  }

  final TextEditingController? controller;

  final FocusNode? focusNode;

  bool get submitEnabled => controller?.text.trim().isNotEmpty ?? false;

  @override
  String? submit() {
    final text = controller?.text;
    controller?.clear();
    return text;
  }

  @override
  void dispose() {
    super.dispose();
    controller?.removeListener(notifyListeners);
  }
}

class LockInputFieldState with InputState {
  LockInputFieldState(this.text);

  final String? text;

  @override
  void dispose() {}
}

class TodoInputFieldViewModel extends ChangeNotifier with InputViewModelMixin {
  TodoInputFieldViewModel(this.api);

  final BaseListViewModel<dynamic, dynamic> api;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  void submit(String input) {
    api.add(Todo(content: input));
  }

  @override
  InputState initState() {
    return KeyboardInputFieldState(controller: _textEditingController);
  }

  void lock() {
    state = LockInputFieldState(_textEditingController.text);
  }

  void unlock() {
    state = KeyboardInputFieldState(controller: _textEditingController);
  }
}
