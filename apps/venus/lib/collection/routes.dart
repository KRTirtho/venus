import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:venus/screens/home.dart';
import 'package:venus/screens/root.dart';
import 'package:venus/screens/teller.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => RootScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
    GoRoute(
      path: "/teller",
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const TellerScreen(),
    ),
  ],
);
