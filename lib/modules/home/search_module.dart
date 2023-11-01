import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';

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
    var kbdDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Colors.grey[300],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchBar(
          hintText: "Search or jump to...",
          leading: const Icon(Ionicons.search_outline),
          trailing: [
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
        Row(
          children: [
            PopupMenuButton(
              child: IgnorePointer(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: FilledButton.icon(
                    label: const Text("Move Money"),
                    icon: const Icon(Ionicons.chevron_down),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(180, 50),
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
            IconButton.filledTonal(
              icon: Icon(
                Ionicons.flash,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
