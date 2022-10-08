import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'constants/color_schemes.dart';
import 'views/home_screen.dart';
import 'views/search_screen.dart';
import 'views/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      light: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      dark: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      builder: (theme, darkTheme) {
        return MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: const HomeScreen(),
          routes: {
            SearchScreen.routeName: (context) => const SearchScreen(),
            SettingScreen.routeName: (context) => const SettingScreen(),
          },
        );
      },
    );
  }
}
