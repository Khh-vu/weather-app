import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnits { fahrenheit, celsius, kelvin }

extension TemperatureUnitsEx on TemperatureUnits {
  String temperature(num value) {
    switch (this) {
      case TemperatureUnits.fahrenheit:
        return '${((value - 273.15) * 1.8 + 32).toStringAsFixed(2)} °F';
      case TemperatureUnits.celsius:
        return '${(value - 273.15).toStringAsFixed(2)} °C';
      case TemperatureUnits.kelvin:
        return '$value K';
    }
  }
}

class TempUnitsCubit extends Cubit<TemperatureUnits> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TempUnitsCubit() : super(TemperatureUnits.celsius) {
    getTempUnits();
  }

  void getTempUnits() async {
    final prefs = await _prefs;
    final data = prefs.getString('temp_units');

    if (data != null) {
      emit(TemperatureUnits.values.byName(data));
    }
  }

  void changeUnits(TemperatureUnits? temperatureUnits) async {
    if (temperatureUnits == null) return;
    final prefs = await _prefs;
    await prefs.setString('temp_units', temperatureUnits.name);
    emit(temperatureUnits);
  }
}
