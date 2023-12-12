import 'package:flutter/cupertino.dart';
import 'package:framework/list.dart';
import 'package:provider/provider.dart';

import '../applications/applications_modal.dart';
import 'contacts_vm.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute(
      builder: (_) => Provider(
        create: (context) => ContactsViewModel(),
        child: const ContactsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ContactsViewModel>();

    return BaseList(
      itemBuilder: _ContactItem.itemBuilder,
      viewModel: vm,
      primary: true,
      topSliver: CupertinoSliverNavigationBar(
        largeTitle: const Text('Contacts'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => ApplicationsModal.show(context),
          child: const Text('Applications'),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem(this.model);

  final ContactModel model;

  static Widget itemBuilder(ContactModel model, int index) {
    return _ContactItem(model);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 联系人列表的单个Widget
    return const Placeholder();
  }
}
