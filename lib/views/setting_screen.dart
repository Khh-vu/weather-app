import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubits/temp_units/temp_units_cubit.dart';
import '../cubits/theme/theme_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) => ListTile(
              leading: SizedBox(
                height: double.infinity,
                child: themeMode == ThemeMode.light
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode),
              ),
              title: const Text('Theme'),
              subtitle: Text(
                toBeginningOfSentenceCase(themeMode.name)!,
              ),
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Theme'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <RadioListTile>[
                      for (var mode in ThemeMode.values)
                        RadioListTile<ThemeMode>(
                          title: Text(toBeginningOfSentenceCase(mode.name)!),
                          value: mode,
                          groupValue: context.watch<ThemeCubit>().state,
                          onChanged: (value) {
                            context.read<ThemeCubit>().changeTheme(value);
                          },
                        ),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCEL'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<TempUnitsCubit, TemperatureUnits>(
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, tempUnits) => ListTile(
              leading: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.thermostat),
              ),
              title: const Text('Temperature Units'),
              subtitle: Text(
                toBeginningOfSentenceCase(tempUnits.name)!,
              ),
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Temperature Units'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <RadioListTile>[
                      for (var units in TemperatureUnits.values)
                        RadioListTile<TemperatureUnits>(
                          title: Text(toBeginningOfSentenceCase(units.name)!),
                          value: units,
                          groupValue: tempUnits,
                          toggleable: true,
                          onChanged: (value) {
                            context.read<TempUnitsCubit>().changeUnits(value);
                          },
                        ),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCEL'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
