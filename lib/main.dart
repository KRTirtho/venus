import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venus/components/sidebar/sidebar.dart';
import 'package:venus/screens/home.dart';

void main() {
  runApp(const Venus());
}

ThemeData createTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final color = isDark ? Colors.blue[400]! : Colors.blueAccent[700]!;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: color,
    brightness: brightness,
  ).copyWith(
    primary: color,
  );

  final surfaceTintColor = isDark ? null : Colors.transparent;
  final theme = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    cardTheme: CardTheme(
      elevation: 4,
      surfaceTintColor: surfaceTintColor,
      shadowColor: Colors.black38,
    ),
    popupMenuTheme: PopupMenuThemeData(
      elevation: 4,
      surfaceTintColor: surfaceTintColor,
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
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
    ),
    iconTheme: const IconThemeData(size: 16),
  );

  return theme.copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme),
  );
}

class Venus extends StatefulHookWidget {
  const Venus({Key? key}) : super(key: key);

  @override
  State<Venus> createState() => VenusState();
}

class VenusState extends State<Venus> {
  var themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light || themeMode == ThemeMode.system
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return MaterialApp(
      home: Sidebar(
        selectedIndex: selectedIndex.value,
        onSelectedIndexChanged: (index) {
          selectedIndex.value = index;
        },
        child: const HomeScreen(),
      ),
      theme: createTheme(Brightness.light),
      darkTheme: createTheme(Brightness.dark),
      themeMode: themeMode,
    );
  }
}
