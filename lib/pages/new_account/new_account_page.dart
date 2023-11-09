import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_account_vm.dart';

class NewAccountPage extends StatelessWidget {
  const NewAccountPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(
      builder: (_) => ChangeNotifierProvider(
        create: (context) => NewAccountViewModel(),
        child: const NewAccountPage(key: ValueKey('NewAccountPage')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('New Account', style: TextStyle(color: CupertinoColors.label.resolveFrom(context))),
      ),
      body: const _Widget(),
    );
  }
}

class _Widget extends StatelessWidget {
  const _Widget();

  @override
  Widget build(BuildContext context) {
    final NewAccountViewModel vm = context.watch();
    return Column(
      children: [
        const Spacer(),
        FractionallySizedBox(
          widthFactor: 0.75,
          child: CupertinoTextField(
            controller: vm.controller,
            placeholder: 'User ID',
          ),
        ),
        const SizedBox(height: 4),
        FractionallySizedBox(
          widthFactor: 0.75,
          child: CupertinoTextField(
            controller: vm.passwdController,
            placeholder: 'Password',
            obscureText: true,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Remember Password'),
            CupertinoSwitch(
              value: vm.remember,
              onChanged: vm.rememberPassword,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Auto Login'),
            CupertinoSwitch(
              value: vm.auto,
              onChanged: vm.autoLogin,
            ),
          ],
        ),
        const Spacer(flex: 2,),
        CupertinoButton(
          onPressed: () => vm.login(Navigator.of(context).pop),
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
