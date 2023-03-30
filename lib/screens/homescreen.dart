import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/weather_model.dart';
import '../service/location_finder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocationFinder locationData;

  Future<WeatherModel> getWeather() async {
    locationData = LocationFinder();
    await locationData.getCurrentLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      debugPrint('Location Error');
    } else {
      debugPrint(
          'lat: ${locationData.latitude} \n lng: ${locationData.longitude}');
    }
    var lat = locationData.latitude;
    var lon = locationData.longitude;
    try {
      var response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=d6252210c5c5d0de96584180e2e59732');
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
      return WeatherModel();
    } on DioError catch (e) {
      return Future.error(e.message.toString());
    }
  }

  late Future<WeatherModel> _myWeather;

  @override
  void initState() {
    super.initState();
    _myWeather = getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2),
              Color(0xFF4A00E0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 30.0,
          ),
          child: Stack(
            children: [
              SafeArea(
                top: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    FutureBuilder<WeatherModel>(
                      future: _myWeather,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.name!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(
                                        'http://openweathermap.org/img/w/${snapshot.data!.icon}.png',
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                snapshot.data!.aboutWeather!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateTime.now().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Builder(builder: (context) {
                                switch (snapshot.data!.weatherCondition) {
                                  case 'Thunderstorm':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/thunder.png',
                                        ),
                                      )),
                                    );
                                  case 'Drizzle':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/drizzle.png',
                                        ),
                                      )),
                                    );
                                  case 'Rain':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/rain.png',
                                        ),
                                      )),
                                    );
                                  case 'Snow':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/snow.png',
                                        ),
                                      )),
                                    );
                                  case 'Atmosphere':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/fog.png',
                                        ),
                                      )),
                                    );
                                  case 'Clear':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/clear.png',
                                        ),
                                      )),
                                    );
                                  case 'Clouds':
                                    return Container(
                                      height: 250,
                                      width: 250,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/mist.png',
                                        ),
                                      )),
                                    );
                                }
                                return Container(
                                  height: 250,
                                  width: 250,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/cycle.png',
                                    ),
                                  )),
                                );
                              }),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Temperature',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${snapshot.data!.temperature.toString()} °',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Humidity',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${snapshot.data!.humidity}%',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Wind Speed',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${snapshot.data!.windSpeed} km/h',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Wind Degree',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${snapshot.data!.windDegree} °',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
