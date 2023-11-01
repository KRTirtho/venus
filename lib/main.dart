import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:venus/screens/home.dart';

void main() {
  runApp(const Venus());
}

class Venus extends StatefulHookWidget {
  const Venus({Key? key}) : super(key: key);

  @override
  State<Venus> createState() => VenusState();
}

class VenusState extends State<Venus> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blueAccent[700]!,
      brightness: Brightness.light,
    ).copyWith(
      primary: Colors.blueAccent[700]!,
    );
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: colorScheme,
        cardTheme: const CardTheme(
          elevation: 4,
          surfaceTintColor: Colors.transparent,
        ),
        popupMenuTheme: const PopupMenuThemeData(
          elevation: 4,
          surfaceTintColor: Colors.transparent,
          position: PopupMenuPosition.under,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.lightBlue,
        ),
        searchBarTheme: SearchBarThemeData(
          elevation: const MaterialStatePropertyAll(0),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: colorScheme.outline,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
