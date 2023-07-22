import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/base_box_manager.dart';
import 'package:pivot_chat/model/account.dart';
import 'package:pivot_chat/pages/dev/pc_dev_counter_bloc.dart';

class PCDevPage extends StatelessWidget {
  const PCDevPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Align(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.watch<PCDevBloc>().state.toString()),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.push('/'),
              child: const Text('Home'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/login'),
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = Random().nextInt(100000).toString();
                accountManager.put(
                  PCLocalAccount(
                    name: name,
                    id: Random().nextInt(1000),
                    email: "$name's Email",
                    rememberPasswd: 1,
                  ),
                );
              },
              child: const Text('Add Random account'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'add',
            child: const Icon(Icons.add),
            onPressed: () => context.read<PCDevBloc>().increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'remove',
            child: const Icon(Icons.remove),
            onPressed: () => context.read<PCDevBloc>().decrement(),
          ),
        ],
      ),
    );
  }
}
