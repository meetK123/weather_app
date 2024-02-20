import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/common/header_View.dart';
import 'package:weather/common/weather_view.dart';
import 'package:weather/provider/weather_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (BuildContext context, WeatherProvider value, Widget? child) { return const Column(
            children: [
              HeaderView(),

              WeatherView(),

            ],
          ); },

        ),
      ),
    );
  }
}


