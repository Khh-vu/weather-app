import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/theme_provider.dart';
import '../providers/weather/weather_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  static String routeName = '/setting';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherNotifierProvider);

    ref.listen(
      weatherNotifierProvider,
      (_, __) => Navigator.of(context).pop(),
    );

    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          ListTile(
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
                        groupValue: ref.watch(themeProvider),
                        onChanged: (value) =>
                            ref.read(themeProvider.notifier).changeTheme(value),
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
          ListTile(
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.thermostat),
            ),
            title: const Text('Temperature Units'),
            subtitle: Text(
              toBeginningOfSentenceCase(state.units.name)!,
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
                        groupValue: state.units,
                        toggleable: true,
                        onChanged: (value) => ref
                            .read(weatherNotifierProvider.notifier)
                            .changeUnits(value),
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
          )
        ],
      ),
    );
  }
}
