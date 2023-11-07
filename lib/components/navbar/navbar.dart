import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:venus/components/navbar/search_module.dart';
import 'package:venus/components/navbar/use_controller.dart';

final sidebarTiles = [
  (icon: Ionicons.home_outline, title: "Home"),
  (icon: Ionicons.list_outline, title: "Transactions"),
  (icon: Ionicons.cash_outline, title: "Payments"),
  (icon: Ionicons.card_outline, title: "Cards"),
  (icon: Ionicons.analytics_outline, title: "Capital"),
  (icon: Ionicons.people_outline, title: "Accounts"),
];

class Navbar extends HookWidget {
  final int selectedIndex;
  final void Function(int) onSelectedIndexChanged;
  final Widget child;

  const Navbar({
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final bottomBarController = useScrollController();
    final controller = useSidebarXController(
      selectedIndex: selectedIndex,
      extended: true,
    );

    final theme = Theme.of(context);

    final mediaQuery = MediaQuery.of(context);
    final isSmallerScreen = mediaQuery.size.width < 600;

    final previousIndex = usePrevious(selectedIndex);

    useEffect(() {
      if (controller.selectedIndex != selectedIndex) {
        controller.selectIndex(selectedIndex);
      }
      controller.addListener(() {
        onSelectedIndexChanged(controller.selectedIndex);
      });
      return null;
    }, [selectedIndex]);

    return Scaffold(
      body: Row(
        children: [
          if (!isSmallerScreen)
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
                            : theme.colorScheme.onBackground,
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
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            theme.colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Gap(10),
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
                extendedTheme: SidebarXTheme(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Color.lerp(
                      theme.colorScheme.background,
                      theme.colorScheme.onBackground,
                      0.05,
                    ),
                  ),
                  selectedItemDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
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
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1080,
                  ),
                  child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(scrollbars: false),
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverAppBar(
                          flexibleSpace: const SafeArea(child: SearchModule()),
                          expandedHeight: 130,
                          floating: true,
                          pinned: true,
                          snap: true,
                          primary: true,
                          surfaceTintColor: Colors.transparent,
                          bottom: !isSmallerScreen
                              ? null
                              : PreferredSize(
                                  preferredSize:
                                      const Size.fromHeight(kToolbarHeight + 4),
                                  child: ColoredBox(
                                    color: theme.colorScheme.background,
                                    child: ScrollConfiguration(
                                      behavior: const ScrollBehavior().copyWith(
                                        dragDevices: {
                                          PointerDeviceKind.touch,
                                          PointerDeviceKind.mouse,
                                        },
                                        scrollbars: false,
                                      ),
                                      child: SingleChildScrollView(
                                        controller: bottomBarController,
                                        scrollDirection: Axis.horizontal,
                                        child: SalomonBottomBar(
                                          currentIndex: selectedIndex,
                                          onTap: (index) {
                                            controller.selectIndex(index);
                                            if (previousIndex == null) {
                                              return;
                                            }

                                            bottomBarController.animateTo(
                                              previousIndex > index
                                                  ? bottomBarController
                                                      .position.minScrollExtent
                                                  : bottomBarController
                                                      .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          items: sidebarTiles.mapIndexed(
                                            (index, e) {
                                              return SalomonBottomBarItem(
                                                icon: Icon(e.icon),
                                                title: Text(e.title),
                                                unselectedColor: theme
                                                    .colorScheme.onBackground,
                                                selectedColor:
                                                    theme.colorScheme.primary,
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
