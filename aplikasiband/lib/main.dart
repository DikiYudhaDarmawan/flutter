import 'package:flutter/material.dart';
import 'package:myapp/band/about_band.dart';
import 'package:myapp/band/home_band.dart';
import 'package:myapp/band/list_band.dart';

void main() {
  runApp(aplikasiband());
}

class aplikasiband extends StatelessWidget {
  const aplikasiband({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "home": (context) => const HomeBand(),
        "/about": (context) => const AboutBand(),
        "/band": (context) => ListBand(),
      },
      initialRoute: "home",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Belajar Flutter'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: HomeBand(),
      ),
    );
  }
}
