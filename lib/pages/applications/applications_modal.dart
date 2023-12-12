import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/list.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/image/pc_network_image.dart';
import 'applications_vm.dart';

class ApplicationsModal extends StatelessWidget {
  const ApplicationsModal({super.key});

  static void show(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (_) => Provider(
        create: (context) => ApplicationsViewModel(),
        child: const ApplicationsModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ApplicationsViewModel>();

    return CupertinoPageScaffold(
      child: BaseList(
        itemBuilder: _ApplicationsItem.itemBuilder,
        viewModel: vm,
        primary: true,
        topSliver: const SliverAppBar(title: Text('Applications')),
      ),
    );
  }
}

class _ApplicationsItem extends StatelessWidget {
  const _ApplicationsItem(this.model);

  final FriendApplicationModel model;

  static Widget itemBuilder(FriendApplicationModel model, int index) {
    return _ApplicationsItem(model);
  }

  @override
  Widget build(BuildContext context) {
    final Widget trailing;

    if (model.status == FriendApplicationStatus.unhandled) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.read<ApplicationsViewModel>().accept(model),
            child: const Text('Agree'),
          ),
          const SizedBox(width: 8),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.read<ApplicationsViewModel>().reject(model),
            child: const Text('Reject'),
          ),
        ],
      );
    } else {
      trailing = Text(model.status.text);
    }

    return ListTile(
      title: Text(model.fromUserNickName),
      leading: CircleAvatar(
        child: PCNetworkImage(imageUrl: model.faceUrl),
      ),
      subtitle: Text(model.addWording),
      trailing: trailing,
    );
  }
}
