import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String country;
  final String city;
  final num lat;
  final num lon;

  const City({
    required this.country,
    required this.city,
    required this.lat,
    required this.lon,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      country: json['country'],
      city: json['name'],
      lat: json['coord']['lat'],
      lon: json['coord']['lon'],
    );
  }

  String get name {
    return country.isEmpty ? city : '$city, $country';
  }

  @override
  String toString() {
    return 'City(country: $country, city: $city, lat: $lat, lon: $lon)';
  }

  @override
  List<Object?> get props => [country, city, lat, lon];
}
