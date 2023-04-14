import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock Stream',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late  bool _isRunning = true;
  String buttonText = 'Stop';

  Stream<String> _clock() async*{
    while(_isRunning){
      await Future<void>.delayed(const Duration(seconds:1));
      DateTime current = DateTime.now();
      yield '${current.hour}:${current.minute}:${current.second}';

  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Stream'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<String>(
              stream: _clock(),
              builder:(BuildContext context, AsyncSnapshot<String> snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data!, style: const TextStyle(fontSize: 40));
                }
                return const CircularProgressIndicator();
              }
            ),
            SizedBox(width: 100,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _isRunning ? buttonText = 'Start' : buttonText = 'Stop';
                    _isRunning = !_isRunning;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_isRunning ? Icons.stop : Icons.play_arrow),
                    Text(buttonText),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

