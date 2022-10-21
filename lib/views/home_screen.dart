import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubits/cubit.dart';
import 'search_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<WeatherCubit>(context).fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          switch (state.status) {
            case WeatherStatus.initial:
            case WeatherStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case WeatherStatus.error:
            case WeatherStatus.loaded:
              final units = context.watch<WeatherCubit>().state.units;
              return RefreshIndicator(
                edgeOffset: 20,
                onRefresh: () => context.read<WeatherCubit>().fetchWeather(),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(state.weather.city),
                      actions: <Widget>[
                        IconButton(
                          onPressed: () async {
                            final city = await Navigator.of(context)
                                .pushNamed(SearchScreen.routeName) as String?;

                            if (!mounted) return;

                            if (city != null) {
                              context.read<WeatherCubit>().fetchWeather(city);
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
                                  'http://openweathermap.org/img/wn/${state.weather.icon}@4x.png',
                                  scale: 1.5,
                                ),
                                Text(
                                  units.temperature(state.weather.temp),
                                  style: textTheme.headline3,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.weather.weather,
                                  style: textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  toBeginningOfSentenceCase(
                                    state.weather.description,
                                  )!,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${state.weather.windSpeed} m/s'),
                                      Text('${state.weather.pressure} hPa'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${state.weather.humidity} %'),
                                      Text(
                                        units.temperature(
                                          state.weather.feelsLike,
                                        ),
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
                                color:
                                    textTheme.bodyText2!.color!.withOpacity(.5),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: DateFormat()
                                      .format(state.weather.dateTime),
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
        },
      ),
    );
  }
}
