import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            builder: (context, state) {
              return ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: state == ThemeMode.light
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode),
                ),
                title: const Text('Theme'),
                subtitle: Text(
                  toBeginningOfSentenceCase(state.name)!,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Theme'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <RadioListTile>[
                          for (var themeMode in ThemeMode.values)
                            RadioListTile<ThemeMode>(
                              title: Text(toBeginningOfSentenceCase(
                                themeMode.name,
                              )!),
                              value: themeMode,
                              groupValue: state,
                              toggleable: true,
                              onChanged: (value) {
                                if (value != null) {
                                  context.read<ThemeCubit>().changeTheme(value);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('CANCEL'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
