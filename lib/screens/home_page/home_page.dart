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
  void initState() {
    super.initState();

    context.read<WeatherProvider>().getUserLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderView(),
              const SizedBox(
                height: 50,
              ),
              const WeatherView(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onRefresh,
          tooltip: 'Refresh',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  void onRefresh() {
    context.read<WeatherProvider>().getUserLocation(context);
  }
}
