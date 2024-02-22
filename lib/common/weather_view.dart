import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/weather_provider.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

 final weatherProvider =   context.watch<WeatherProvider>();
          if(weatherProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }else {
            return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius:1

          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/weather/${weatherProvider.weather.weather?[0].icon??'01d'}.png',
                height: 75,
                width: 75,
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weatherProvider.weather.main?.temp?.toInt()??0}' " \u00B0",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Text(
                    weatherProvider.weather.weather?.first.main??'',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _windAndHumidityView(isWind: true, num: weatherProvider.weather.wind?.speed?.toInt() ?? 0),
                 const VerticalDivider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                _windAndHumidityView(isWind: false, num:weatherProvider.weather.main?.humidity ?? 0),
              ],
            ),
          ),
        ],
      ),
    );
          }
  }

  Column _windAndHumidityView({required bool isWind, required int num}) {
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
