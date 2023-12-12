import 'package:flutter/cupertino.dart';

// TODO;
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return CupertinoPageRoute(
      builder: (_) => const SettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
