import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:venus/components/sidebar/sidebar.dart';
import 'package:venus/main.dart';

const moveMoneyItems = [
  (icon: Icon(Ionicons.paper_plane_outline), title: "Pay Someone"),
  (icon: Icon(Ionicons.cash_outline), title: "Add or Receive Funds"),
  (
    icon: RotatedBox(quarterTurns: 2, child: Icon(Ionicons.log_out_outline)),
    title: "Payment Request",
  ),
  (icon: Icon(Ionicons.repeat_outline), title: "Payment Request"),
];

class SearchModule extends HookWidget {
  const SearchModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme) = Theme.of(context);
    final kbdDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: colorScheme.surfaceVariant,
    );

    final venusAppState = context.findAncestorStateOfType<VenusState>();

    final isSmallerScreen = MediaQuery.of(context).size.width < 600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isSmallerScreen)
          IconButton(
            icon: Icon(Ionicons.menu_outline, color: colorScheme.onSurface),
            onPressed: () {
              Scaffold.of(Scaffold.of(context).context).openDrawer();
            },
          ),
        Flexible(
          child: SizedBox(
            height: 40,
            child: SearchBar(
              hintText: "Search or jump to...",
              leading: Icon(
                Ionicons.search_outline,
                color: colorScheme.onSurface,
              ),
              trailing: isSmallerScreen
                  ? []
                  : [
                      Container(
                        decoration: kbdDecoration,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Text("Ctrl"),
                      ),
                      const Gap(2),
                      Container(
                        decoration: kbdDecoration,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Text("K"),
                      ),
                    ],
            ),
          ),
        ),
        const Gap(10),
        Row(
          children: [
            PopupMenuButton(
              tooltip: "Move Money",
              icon: isSmallerScreen
                  ? IgnorePointer(
                      child: IconButton.filled(
                        onPressed: () {},
                        icon: Icon(
                          Icons.attach_money_outlined,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    )
                  : null,
              child: isSmallerScreen
                  ? null
                  : IgnorePointer(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: FilledButton.icon(
                          label: const Text("Move Money"),
                          icon: const Icon(Ionicons.chevron_down),
                          style: FilledButton.styleFrom(
                            minimumSize: isSmallerScreen
                                ? const Size(150, 45)
                                : const Size(180, 50),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
              itemBuilder: (context) {
                return [
                  for (final item in moveMoneyItems)
                    PopupMenuItem(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: item.icon,
                        title: Text(item.title),
                      ),
                    ),
                ];
              },
            ),
            const Gap(15),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: kElevationToShadow[2]!,
              ),
              child: IconButton.filled(
                icon: Icon(
                  Ionicons.flash,
                  color: Theme.of(context).colorScheme.primary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.background,
                ),
                onPressed: () {
                  venusAppState?.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
