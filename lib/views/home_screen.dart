import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Country'),
            Text('Date time'),
          ],
        ),
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
                Icon(
                  Icons.wb_sunny_rounded,
                  size: height * .1,
                  color: Colors.orange,
                ),
                const Text(
                  'Temp',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Weather',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Weather Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    children: const [
                      Text(
                        'x meter/sec',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'x meter/sec',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'x hPa',
                        style: TextStyle(color: Colors.white),
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
                    children: const [
                      Text(
                        'x %',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'x meter',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'x Celsius',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
