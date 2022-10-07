import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../models/weather.dart';
import '../services/location_service.dart';
import '../services/weather_api_client.dart';
import 'search_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Weather> futureWeather;

  Future<Weather> getCurrentWeather() async {
    try {
      Position? position = await LocationService.getLocation();

      if (position != null) {
        double lat = position.latitude;
        double lon = position.longitude;

        final city = await WeatherApiClient().getCurrentCity(
          lat: lat,
          lon: lon,
        );

        return WeatherApiClient().getCurrentWeatherByCityName(cityName: city);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return WeatherApiClient().getCurrentWeatherByCityName(cityName: 'Hanoi');
  }

  @override
  void initState() {
    futureWeather = getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: FutureBuilder<Weather>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.hasData) {
            final Weather weather = snapshot.data!;

            return RefreshIndicator(
              edgeOffset: 20,
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  futureWeather = getCurrentWeather();
                });
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(weather.city),
                    actions: <Widget>[
                      IconButton(
                        onPressed: () async {
                          final city = await Navigator.of(context)
                              .pushNamed(SearchScreen.routeName) as String?;

                          if (city != null) {
                            setState(() {
                              futureWeather = WeatherApiClient()
                                  .getCurrentWeatherByCityName(cityName: city);
                            });
                          }
                        },
                        tooltip: 'Search',
                        icon: const Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            SettingScreen.routeName,
                          );
                        },
                        tooltip: 'Setting',
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * .45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                'http://openweathermap.org/img/wn/${weather.icon}@4x.png',
                                scale: 1.5,
                              ),
                              Text(
                                '${weather.temp} °C',
                                style: textTheme.headline3,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                weather.weather,
                                style: textTheme.headline2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                toBeginningOfSentenceCase(weather.description)!,
                                style: textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Additional Info',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const Divider(thickness: 1),
                        Container(
                          height: height * .15,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Wind',
                                      style: TextStyle(
                                        color: textTheme.bodyText2!.color!
                                            .withOpacity(.5),
                                      ),
                                    ),
                                    Text(
                                      'Pressure',
                                      style: TextStyle(
                                        color: textTheme.bodyText2!.color!
                                            .withOpacity(.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${weather.windSpeed} m/s'),
                                    Text('${weather.pressure} hPa'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                        color: textTheme.bodyText2!.color!
                                            .withOpacity(.5),
                                      ),
                                    ),
                                    Text(
                                      'Feels like',
                                      style: TextStyle(
                                        color: textTheme.bodyText2!.color!
                                            .withOpacity(.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${weather.humidity} %'),
                                    Text('${weather.feelsLike} °C'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            text: 'Last Update:  ',
                            style: TextStyle(
                              color:
                                  textTheme.bodyText2!.color!.withOpacity(.5),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: DateFormat().format(weather.dateTime),
                                style: textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
