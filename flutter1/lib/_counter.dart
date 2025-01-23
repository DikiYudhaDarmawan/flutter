import 'package:flutter/material.dart';

class counter extends StatelessWidget {
  const counter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Flutter Example App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      if (_counter >= 30) {
        final snackBar = SnackBar(
          content: const Text('Hayoh we ditambahan'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        _counter++;
      };
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter <= -5) {
        final snackBar = SnackBar(
          content: const Text('Hayoh we dikurangan'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        _counter--;
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('You have pushed the button this many times:',),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: FloatingActionButton(
                      onPressed: _decrementCounter,
                      tooltip: 'Increment',
                      child: const Icon(Icons.minimize),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}