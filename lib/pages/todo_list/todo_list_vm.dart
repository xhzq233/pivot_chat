import 'package:framework/base.dart';
import 'package:framework/list.dart';

import 'todo_model.dart';

class TodoDataViewModel with DisposeMixin, BaseListViewModel<Todo, String> {
  final List<Todo> _list = [
    const Todo(content: '111'),
    const Todo(content: '112'),
    const Todo(content: '113'),
    const Todo(content: '114'),
    const Todo(content: '115'),
  ];

  @override
  List<Todo> get list => _list;
}
