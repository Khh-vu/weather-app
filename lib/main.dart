import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/color_schemes.dart';
import 'cubits/cubit.dart';
import 'repositories/weather_repository.dart';
import 'simple_bloc_observer.dart';
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
    return RepositoryProvider(
      create: (_) => WeatherRepository(
          // weatherApiClient: WeatherApiClient(),
          ),
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider<TempUnitsCubit>(
            create: (_) => TempUnitsCubit(),
          ),
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
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
              home: const HomeScreen(),
              routes: {
                SearchScreen.routeName: (context) => const SearchScreen(),
                SettingScreen.routeName: (context) => const SettingScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
