import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather.dart';
import '../services/weather_api_client.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return FutureBuilder<Weather>(
      future: WeatherApiClient().getCurrentWeather(location: 'Hanoi'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
        if (snapshot.hasData) {
          final Weather weather = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(weather.country),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: height * .45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                      ),
                      Text(
                        '${weather.temp} °C',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        weather.weather,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        toBeginningOfSentenceCase(weather.description)!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Text(
                  'Additional Info',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  color: Colors.white30,
                  thickness: 1,
                ),
                Container(
                  height: height * .15,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wind',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            Text(
                              'Gust',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            Text(
                              'Pressure',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.windSpeed} m/s',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${weather.windGust} m/s',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${weather.pressure} hPa',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Humidity',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            Text(
                              'Visibility',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            Text(
                              'Feels like',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.humidity} %',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${weather.visibility} m',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${weather.feelsLike} °C',
                              style: const TextStyle(color: Colors.white),
                            ),
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
                      color: Colors.white.withOpacity(.5),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: DateFormat().format(weather.dateTime),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
