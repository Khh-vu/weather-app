part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  factory ThemeState.defaultTheme() {
    return const ThemeState(themeMode: ThemeMode.system);
  }

  factory ThemeState.fromSharedPreferences(String name) {
    return ThemeState(themeMode: ThemeMode.values.byName(name));
  }

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  bool get isLight => themeMode == ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  bool get isSystem => themeMode == ThemeMode.system;

  @override
  List<Object?> get props => [themeMode];
}
