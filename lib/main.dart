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
  Dice dice = Dice(size: 10);
  late Timer timer;
  dynamic resultNum = 0; // 랜덤으로 돌아가고 있는걸 보이게 하기 위해서
  String resultView = ''; // 뽑은 결과를 화면에 보이게 만들기 위해서
  bool isStart = false; // 돌고있는지 안돌고 있는지.

  void start() {
    if (!isStart) {
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        dice.shake(); // dice에 있는 값을 섞는다.
        setState(() {
          resultNum = dice.dice[0];
          isStart = true;
        });
      });
    }
  }

  void pickUp() {
    if (dice.dice.isNotEmpty && isStart) {
      setState(() {
        // 화면을 실시간으로 바꾸는 것 -> setState
        resultView = '$resultView ${dice.pick()}';
      });
      if (dice.dice.isEmpty) {
        timer.cancel();
        setState(() {
          isStart = false;
          resultNum = '끝 뿡';
        });
      }
    }
  }

  void resetDice() {
    setState(() {
      resultNum = '';
      resultView = '';
      dice.init();
      if (isStart) {
        timer.cancel();
      }
      isStart = false;
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
                  child: Center(
                    child: Text(
                      resultView,
                      style: const TextStyle(
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
                            onPressed: pickUp,
                            icon: const Icon(Icons.check_circle)),
                        IconButton(
                            iconSize: 100,
                            onPressed: resetDice,
                            icon: const Icon(Icons.restore))
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
