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
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: state.isLight
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode),
                ),
                title: const Text('Theme'),
                subtitle: Text(
                  toBeginningOfSentenceCase(state.themeMode.name)!,
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
                              groupValue: state.themeMode,
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
                      // ListView.builder(
                      //   reverse: true,
                      //   shrinkWrap: true,
                      //   itemCount: ThemeMode.values.length,
                      //   itemBuilder: (_, index) {
                      //     return RadioListTile<ThemeMode>(
                      //       title: Text(toBeginningOfSentenceCase(
                      //         ThemeMode.values[index].name,
                      //       )!),
                      //       value: ThemeMode.values[index],
                      //       groupValue: state.themeMode,
                      //       toggleable: true,
                      //       onChanged: (value) {
                      //         context.read<ThemeCubit>().changeTheme(value!);
                      //       },
                      //     );
                      //   },
                      // ),
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
