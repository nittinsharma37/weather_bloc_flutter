import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_bloc1/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _getWeahterIcon({required int weather}) {
    switch (weather) {
      case > 200 && < 300:
        return "assets/1.png";
      case > 300 && < 400:
        return "assets/2.png";
      case > 500 && < 600:
        return "assets/3.png";
      case > 600 && < 700:
        return "assets/4.png";
      case > 700 && < 800:
        return "assets/5.png";
      case == 800:
        return "assets/6.png";
      case > 800 && <= 804:
        return "assets/7.png";
      default:
      return "assets/8.png";
    }
  }


String _getGreetingText() {
  // Get the current time
  DateTime now = DateTime.now();
  
  // Define the intervals for different times of the day
  final morningStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
  final morningEnd = DateTime(now.year, now.month, now.day, 12, 0, 0);
  
  final afternoonStart = DateTime(now.year, now.month, now.day, 12, 0, 0);
  final afternoonEnd = DateTime(now.year, now.month, now.day, 17, 59, 59);
  
  final eveningStart = DateTime(now.year, now.month, now.day, 18, 0, 0);
  final eveningEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

  // Determine the greeting based on the current time
  String greetingText = '';
  if (now.isAfter(morningStart) && now.isBefore(morningEnd)) {
    greetingText = 'Good morning';
  } else if (now.isAfter(afternoonStart) && now.isBefore(afternoonEnd)) {
    greetingText = 'Good afternoon';
  } else if (now.isAfter(eveningStart) && now.isBefore(eveningEnd)) {
    greetingText = 'Good evening';
  } else {
    greetingText = 'Hello';
  }

  return greetingText;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(3, -0.3),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -0.3),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 100,
                      sigmaY: 100,
                    ),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  (state is WeatherBlocLoading || state is WeatherBlocInitial)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is WeatherBlocSuccess
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "📍 ${state.weather.areaName}, ${state.weather.country}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                   Text(
                                   _getGreetingText(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      _getWeahterIcon(weather: state.weather.weatherConditionCode!),
                                      scale: 2,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${state.weather.temperature!.celsius!.round()}°C",
                                      style: const TextStyle(
                                          fontSize: 56,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${state.weather.weatherMain}",
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Text(
                                      DateFormat('EE dd MMM-')
                                          .add_jm()
                                          .format(state.weather.date!),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/6.png",
                                            scale: 11,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Sunrise",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                DateFormat().add_jm().format(
                                                    state.weather.sunrise!),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/10.png",
                                            scale: 11,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Sunset",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                DateFormat().add_jm().format(
                                                    state.weather.sunset!),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/11.png",
                                            scale: 11,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Temp max",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${state.weather.tempMax!.celsius!.round()}°C",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/12.png",
                                            scale: 11,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Temp min",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${state.weather.tempMin!.celsius!.round()}°C",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Soemthing went wrong!",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
