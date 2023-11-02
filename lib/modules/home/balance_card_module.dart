import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:ionicons/ionicons.dart';

final randomDataFor1MonthPerDay = List.generate(
  30,
  (index) => FlSpot(
    index.toDouble() + 1,
    (Random().nextDouble() * 1000000).roundToDouble(),
  ),
);
final totalBalance = randomDataFor1MonthPerDay.fold(
  0.0,
  (previousValue, element) => previousValue + element.y,
);
final differenceOfLast2 = randomDataFor1MonthPerDay.last.y -
    randomDataFor1MonthPerDay[randomDataFor1MonthPerDay.length - 2].y;
final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

class BalanceCardModule extends HookWidget {
  const BalanceCardModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const hiddenAxisTitle =
        AxisTitles(sideTitles: SideTitles(showTitles: false));
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 430,
        child: Stack(
          children: [
            LineChart(
              LineChartData(
                maxY: 1000000 * 2,
                minY: 0,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: hiddenAxisTitle,
                  rightTitles: hiddenAxisTitle,
                  leftTitles: hiddenAxisTitle,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: (value, meta) {
                        if (value == meta.max || value == meta.min) {
                          return const SizedBox();
                        }
                        return Text('Oct ${meta.formattedValue}');
                      },
                      interval: 5,
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: colorScheme.inverseSurface,
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map(
                          (LineBarSpot touchedSpot) => LineTooltipItem(
                            "Oct ${touchedSpot.x.toInt()}\n${formatCurrency.format(touchedSpot.y.toInt())}",
                            TextStyle(
                              color: colorScheme.onInverseSurface,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                        .toList(),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    spots: randomDataFor1MonthPerDay,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(0.5),
                          colorScheme.primary.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    isStrokeCapRound: true,
                    color: colorScheme.primary,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  width: constraints.biggest.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mercury Balance",
                            style: textTheme.bodyLarge,
                          ),
                          Text(
                            formatCurrency.format(totalBalance),
                            style: textTheme.headlineMedium,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RotatedBox(
                                quarterTurns:
                                    differenceOfLast2.isNegative ? 2 : 0,
                                child: Icon(
                                  Icons.arrow_outward_rounded,
                                  size: 16,
                                  color: differenceOfLast2.isNegative
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              Text(
                                formatCurrency.format(differenceOfLast2.abs()),
                                style: textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                              icon: const Icon(Ionicons.chevron_down),
                              label: const Text("Last 30 Days"),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
