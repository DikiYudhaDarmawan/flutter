import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/counter_controller.dart';

class CounterView extends GetView<CounterController> {
  const CounterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx( 
              () =>Text(controller.bilangan.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                child: FloatingActionButton(
                  onPressed: (){controller.tambahSatu();},
                  child: const Icon(Icons.add),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                child: FloatingActionButton(
                  onPressed: (){controller.kurangSatu();},
                  child: const Icon(Icons.minimize),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                child: FloatingActionButton(
                  onPressed: (){controller.reset();},
                  child: const Icon(Icons.refresh),
                ),
              ),
            ),
              ]
            )
          ],
        ))
    );
  }
}
