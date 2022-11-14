import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/color_schemes.dart';
import 'providers/theme_provider.dart';
import 'views/home_screen.dart';
import 'views/search_screen.dart';
import 'views/setting_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(themeProvider.notifier).getThemeMode();
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const HomeScreen(),
      routes: {
        SearchScreen.routeName: (context) => const SearchScreen(),
        SettingScreen.routeName: (context) => const SettingScreen(),
      },
    );
  }
}
