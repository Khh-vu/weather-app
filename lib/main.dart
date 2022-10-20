import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/simple_bloc_observer.dart';

import 'constants/color_schemes.dart';
import 'cubits/temp_units/temp_units_cubit.dart';
import 'cubits/theme/theme_cubit.dart';
import 'views/home_screen.dart';
import 'views/search_screen.dart';
import 'views/setting_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<TempUnitsCubit>(
          create: (_) => TempUnitsCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
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
            home: BlocBuilder<TempUnitsCubit, TemperatureUnits>(
              builder: (context, tempUnits) {
                return HomeScreen(units: tempUnits);
              },
            ),
            routes: {
              SearchScreen.routeName: (context) => const SearchScreen(),
              SettingScreen.routeName: (context) => const SettingScreen(),
            },
          );
        },
      ),
    );
  }
}
