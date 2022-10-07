import 'package:flutter/material.dart';

import 'constants/color_schemes.dart';
import 'views/home_screen.dart';
import 'views/search_screen.dart';
import 'views/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
      routes: {
        SearchScreen.routeName: (context) => const SearchScreen(),
        SettingScreen.routeName: (context) => const SettingScreen(),
      },
    );
  }
}
