import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:ionicons/ionicons.dart';
import 'package:venus/modules/home/balance_card_module.dart';

final formatCurrencyCompact =
    NumberFormat.compactSimpleCurrency(decimalDigits: 0);

class ProgressCardModule extends HookWidget {
  final String title;
  final List<({int amount, String name})> dataSource;
  const ProgressCardModule({
    Key? key,
    required this.title,
    required this.dataSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);
    final randomColors =
        useMemoized(() => Colors.primaries.toList()..shuffle(), []);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.outline,
              ),
            ),
            const Gap(30),
            Text(
              formatCurrency.format(
                dataSource.fold(
                  0,
                  (previousValue, element) => previousValue + element.amount,
                ),
              ),
              style: textTheme.displaySmall,
            ),
            const Gap(20),
            for (final (:amount, :name) in dataSource) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: amount.abs() / 200000,
                          color: randomColors.first,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        formatCurrencyCompact.format(amount),
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(10),
            ],
            const Gap(15),
            Align(
              alignment: Alignment.centerRight,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.chevron_forward,
                    size: 14,
                    color: colorScheme.primary,
                  ),
                  label: Text(
                    "View All",
                    style: TextStyle(
                      color: colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
