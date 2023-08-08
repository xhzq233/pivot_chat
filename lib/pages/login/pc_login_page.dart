import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pivot_chat/pages/login/pc_login_bloc.dart';

class PCLoginPage extends StatelessWidget {
  const PCLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PCLoginSourceBloc sourceBloc = context.watch();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ReorderableListView.builder(
        onReorder: sourceBloc.reorder,
        itemCount: sourceBloc.state.length,
        itemBuilder: (context, index) {
          final item = sourceBloc.state[index];
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
                onPressed: () => sourceBloc.decrement(item),
              ),
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
              onPressed: () => sourceBloc.decrement(item),
            ),
          );
        },
      ),
    );
  }
}
