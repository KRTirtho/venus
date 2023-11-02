import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:random_name_generator/random_name_generator.dart';
import 'package:venus/modules/home/balance_card_module.dart';
import 'package:venus/modules/home/progress_card_module.dart';
import 'package:venus/modules/home/search_module.dart';
import 'package:venus/modules/home/welcome_card_module.dart';

final randomNames = RandomNames(Zone.us);
final progressDataOut = List.generate(
  4,
  (index) => (
    name: randomNames.fullName(),
    amount: Random().nextInt(200000) * -1,
  ),
);
final progressDataIn = List.generate(
  4,
  (index) => (
    name: randomNames.fullName(),
    amount: Random().nextInt(200000),
  ),
);

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    return Builder(builder: (context) {
      return Scaffold(
        body: Scrollbar(
          controller: controller,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                controller: controller,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1080,
                  ),
                  child: Column(
                    children: [
                      const SearchModule(),
                      const Gap(15),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isSmallScreen = constraints.maxWidth < 600;

                          if (isSmallScreen) {
                            return const Column(
                              children: [
                                WelcomeCardModule(),
                                Gap(20),
                                BalanceCardModule(),
                              ],
                            );
                          } else {
                            return const Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: WelcomeCardModule(),
                                ),
                                Gap(20),
                                Expanded(
                                  flex: 5,
                                  child: BalanceCardModule(),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const Gap(20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isSmallScreen = constraints.maxWidth < 600;

                          if (isSmallScreen) {
                            return Column(
                              children: [
                                ProgressCardModule(
                                  title: 'MONEY OUT LAST 30 DAYS',
                                  dataSource: progressDataOut,
                                ),
                                const Gap(20),
                                ProgressCardModule(
                                  title: 'MONEY IN LAST 30 DAYS',
                                  dataSource: progressDataIn,
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                Expanded(
                                  child: ProgressCardModule(
                                    title: 'MONEY OUT LAST 30 DAYS',
                                    dataSource: progressDataOut,
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: ProgressCardModule(
                                    title: 'MONEY IN LAST 30 DAYS',
                                    dataSource: progressDataIn,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
