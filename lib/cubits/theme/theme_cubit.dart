import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeCubit() : super(ThemeState.defaultTheme()) {
    getThemeMode();
  }

  void getThemeMode() async {
    final prefs = await _prefs;
    final data = prefs.getString('theme_mode');

    if (data != null) {
      emit(ThemeState.fromSharedPreferences(data));
    }
  }

  void changeTheme(ThemeMode mode) async {
    final prefs = await _prefs;
    await prefs.setString('theme_mode', mode.name);
    emit(state.copyWith(themeMode: mode));
  }
}
