import 'package:flutter/material.dart';
import 'package:framework/base.dart';
import 'package:framework/list.dart';

import 'todo_model.dart';

class KeyboardInputFieldState with InputFieldState {
  KeyboardInputFieldState({this.controller, this.focusNode}) {
    if (controller != null) {
      _updateBtn();
      controller!.addListener(_updateBtn);
    }
  }

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final addBtnEnabled = ValueNotifier(false);

  void _updateBtn() {
    addBtnEnabled.value = controller?.text.trim().isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context, VoidCallback submit) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffix: ValueListenableBuilder(
            valueListenable: addBtnEnabled,
            builder: (context, bool value, _) => ElevatedButton(
              onPressed: value ? submit : null,
              child: const Text('Add'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String? submit() {
    final text = controller?.text;
    controller?.clear();
    return text;
  }

  @override
  void dispose() {
    super.dispose();
    controller?.removeListener(_updateBtn);
    addBtnEnabled.dispose();
  }
}

class TodoInputFieldViewModel with Disposable, InputFieldViewModelMixin {
  TodoInputFieldViewModel(this.api);

  final BaseListViewModel<dynamic, dynamic> api;

  @override
  late InputFieldState state = KeyboardInputFieldState(controller: _textEditingController);

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose(BuildContext context) {
    super.dispose(context);
    _textEditingController.dispose();
  }

  @override
  void submit(String input) {
    api.add(Todo(content: input));
  }
}
