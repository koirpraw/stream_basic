import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Alert',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class WeatherAlert {
  final String title;
  final String description;
  final String severity;

  WeatherAlert(
      {required this.title, required this.description, required this.severity});
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<WeatherAlert> _weatherAlerts = [];

  Stream<WeatherAlert> _weatherInfo() async* {
    await Future<void>.delayed(const Duration(seconds: 3));
    yield WeatherAlert(
        title: 'Cloudy', description: 'some clouds hovering', severity: 'low');

    await Future<void>.delayed(const Duration(seconds: 3));
    yield WeatherAlert(
        title: 'Rain',
        description: 'Light Rain Expected , get your umbrellas ',
        severity: 'medium');

    await Future<void>.delayed(const Duration(seconds: 3));
    yield WeatherAlert(
        title: 'Thunder',
        description: 'Cloudy sky but no rain, expect thunder storm',
        severity: 'low');

    await Future<void>.delayed(const Duration(seconds: 3));
    yield WeatherAlert(
        title: 'Heavy rainfall',
        description: 'A tornado is on the ground',
        severity: 'Severe');

    await Future<void>.delayed(const Duration(seconds: 3));
    yield WeatherAlert(
        title: 'Sunny', description: 'A clear sunny day', severity: 'Severe');

    await Future<void>.delayed(const Duration(seconds: 3));
    yield WeatherAlert(
        title: 'Cloudy',
        description: 'some clouds hovering',
        severity: 'Severe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Alert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: _weatherInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<WeatherAlert> snapshot) {
              if (snapshot.hasData) {
                _weatherAlerts.add(snapshot.data!);
                return ListView.builder(
                    itemCount: _weatherAlerts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(_weatherAlerts[index].title),
                          subtitle: Text(_weatherAlerts[index].description),
                          trailing: Text(_weatherAlerts[index].severity),
                        ),
                      );
                    });
              }
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Loading.."),
                  CircularProgressIndicator(),
                ],
              ));
            }),
      ),
    );
  }
}
