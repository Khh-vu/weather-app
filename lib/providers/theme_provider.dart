import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeNotifier() : super(ThemeMode.system) {
    getThemeMode();
  }

  void getThemeMode() async {
    final prefs = await _prefs;
    final data = prefs.getString('theme_mode');

    if (data != null) {
      state = ThemeMode.values.byName(data);
    }
  }

  void changeTheme(ThemeMode? mode) async {
    if (mode == null) return;

    final prefs = await _prefs;
    await prefs.setString('theme_mode', mode.name);
    state = mode;
  }
}
