import 'package:flutter/material.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/weather/02d.png',
                height: 75,
                width: 75,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '21' " \u00B0",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Cloudy',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20,),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _windAndHumidityView(isWind: true, num: 8),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                _windAndHumidityView(isWind: false, num: 27),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _windAndHumidityView({required bool isWind, required double num}) {
    return Column(
      children: [
        Image.asset(
          isWind ? 'assets/icons/windspeed.png' : 'assets/icons/humidity.png',
          height: 30,
          width: 30,
        ),
        Text(
          '$num' '${isWind ? 'km/h' : '%'}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          isWind ? 'wind' : 'Humidity',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
