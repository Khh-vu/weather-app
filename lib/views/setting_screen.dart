import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static String routeName = '/setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeMode = AdaptiveTheme.of(context);

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
              child: themeMode.mode.isLight
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
            ),
            title: const Text('Theme'),
            subtitle: Text(themeMode.mode.modeName),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Theme'),
                  content: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: ThemeMode.values.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<AdaptiveThemeMode>(
                        title: Text(toBeginningOfSentenceCase(
                          AdaptiveThemeMode.values[index].name,
                        )!),
                        value: AdaptiveThemeMode.values[index],
                        groupValue: themeMode.mode,
                        onChanged: (value) {
                          setState(() {
                            themeMode.setThemeMode(value!);
                          });
                        },
                      );
                    },
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
          ),
        ],
      ),
    );
  }
}
