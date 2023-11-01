import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:venus/modules/home/balance_card_module.dart';

final recentHistoryData = [
  (
    status: "Nov 1",
    author: "Ops / Payroll",
    amount: formatCurrency.format(234022)
  ),
  (status: "Nov 1", author: "AR", amount: formatCurrency.format(154022)),
  (
    status: "Pending",
    author: "John's Account",
    amount: formatCurrency.format(64022)
  ),
];

class WelcomeCardModule extends HookWidget {
  const WelcomeCardModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(48),
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "VENUS DEMO, INC.",
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const Gap(30),
            Text(
              "Welcome, User",
              style: textTheme.displaySmall,
            ),
            const Gap(20),
            const Text(
              "Here are your company's most recent transactions:",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10),
            DataTable(
              headingRowHeight: 0,
              columnSpacing: 10.0,
              columns: const [
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Author")),
                DataColumn(label: Text("Amount")),
              ],
              rows: [
                for (final row in recentHistoryData)
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          row.status,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          row.author,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(Text(row.amount)),
                    ],
                  ),
              ],
            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
