import 'add_contact_vm.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute(
      builder: (_) {
        return Provider(
          create: (ctx) => AddContactViewModel(),
          child: const AddContactPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 具体可以模仿new_account_page
    return const Placeholder();
  }
}
