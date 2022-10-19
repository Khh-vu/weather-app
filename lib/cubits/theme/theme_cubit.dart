import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeCubit() : super(ThemeMode.system) {
    getThemeMode();
  }

  void getThemeMode() async {
    final prefs = await _prefs;
    final data = prefs.getString('theme_mode');

    if (data != null) {
      emit(ThemeMode.values.byName(data));
    }
  }

  void changeTheme(ThemeMode mode) async {
    final prefs = await _prefs;
    await prefs.setString('theme_mode', mode.name);
    emit(mode);
  }
}
