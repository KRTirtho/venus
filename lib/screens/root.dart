import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:venus/components/navbar/navbar.dart';

class RootScreen extends HookWidget {
  final Widget child;
  const RootScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Navbar(
      selectedIndex: selectedIndex.value,
      onSelectedIndexChanged: (index) {
        selectedIndex.value = index;
      },
      child: child,
    );
  }
}
