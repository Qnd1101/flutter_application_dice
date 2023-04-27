import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_dice/dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Dice dice = Dice(size: 100);
  late Timer timer;
  int resultNum = 0;

  void start() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      dice.shake();
      print(dice.dice[0]);
      setState(() {
        resultNum = dice.dice[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.indigoAccent,
                  child: Center(
                    child: Text(
                      '$resultNum',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 100,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      '결과',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.amber,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            iconSize: 100,
                            onPressed: start,
                            icon: const Icon(Icons.play_circle)),
                        IconButton(
                            iconSize: 100,
                            onPressed: () {},
                            icon: const Icon(Icons.check_circle))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
