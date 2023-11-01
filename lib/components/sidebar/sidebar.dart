import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:venus/components/sidebar/use_controller.dart';

final sidebarTiles = [
  (icon: Ionicons.home_outline, title: "Home"),
  (icon: Ionicons.list_outline, title: "Transactions"),
  (icon: Ionicons.cash_outline, title: "Payments"),
  (icon: Ionicons.card_outline, title: "Cards"),
  (icon: Ionicons.analytics_outline, title: "Capital"),
  (icon: Ionicons.people_outline, title: "Accounts"),
];

class Sidebar extends HookWidget {
  final int selectedIndex;
  final void Function(int) onSelectedIndexChanged;
  final Widget child;

  const Sidebar({
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useSidebarXController(
      selectedIndex: selectedIndex,
      extended: true,
    );

    final theme = Theme.of(context);

    useEffect(() {
      if (controller.selectedIndex != selectedIndex) {
        controller.selectIndex(selectedIndex);
      }
      return null;
    }, [selectedIndex]);

    useEffect(() {
      controller.addListener(() {
        onSelectedIndexChanged(controller.selectedIndex);
      });
      return null;
    }, [controller]);

    return Row(
      children: [
        SafeArea(
          child: SidebarX(
            controller: controller,
            items: sidebarTiles.mapIndexed(
              (index, e) {
                return SidebarXItem(
                  iconWidget: Icon(
                    e.icon,
                    color: selectedIndex == index
                        ? theme.colorScheme.primary
                        : null,
                    size: 16,
                  ),
                  label: e.title,
                );
              },
            ).toList(),
            showToggleButton: false,
            headerBuilder: (context, extended) {
              return Padding(
                padding: const EdgeInsets.all(24).copyWith(left: 12),
                child: Row(
                  children: [
                    Text(
                      'VENUS',
                      style: theme.textTheme.titleLarge?.copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
            theme: SidebarXTheme(
              width: 50,
              margin:
                  EdgeInsets.only(bottom: 10, top: Platform.isMacOS ? 35 : 5),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.primary.withOpacity(0.1),
              ),
              selectedIconTheme: IconThemeData(
                color: theme.colorScheme.primary,
              ),
            ),
            extendedTheme: SidebarXTheme(
              width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.background.withOpacity(0.95),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.surfaceVariant,
              ),
              selectedIconTheme: IconThemeData(
                color: theme.colorScheme.primary,
              ),
              selectedTextStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              itemTextPadding: const EdgeInsets.only(left: 10),
              selectedItemTextPadding: const EdgeInsets.only(left: 10),
              hoverTextStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Expanded(child: child)
      ],
    );
  }
}
