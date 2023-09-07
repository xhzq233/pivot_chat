import 'package:framework/list.dart';

class Todo extends BaseItemModel<String> {
  const Todo({required this.content, this.done = false});

  final String content;

  final bool done;

  @override
  String get key => content;

  Todo copyWith({bool? done}) => Todo(content: content, done: done ?? this.done);
}
