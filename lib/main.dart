import 'package:flutter/material.dart';

import 'pages/pomofocus_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // initial values
    bool _pomodoroIsPressed = true;
    bool _shortBreakIsPressed = false;
    bool _longBreakIsPressed = false;
    bool _startIsPressed = false;

    int _minutes = 25;
    int _seconds = 00;
    int _pomodoroTimer = 25;
    int _shortBreakTimer = 5;
    int _longBreakTimer = 15;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PomofocusPage(
        minutes: _minutes,
        seconds: _seconds,
        pomodoroIsPressed: _pomodoroIsPressed,
        shortBreakIsPressed: _shortBreakIsPressed,
        longBreakIsPressed: _longBreakIsPressed,
        startIsPressed: _startIsPressed,
        pomodoroTimer: _pomodoroTimer,
        shortBreakTimer: _shortBreakTimer,
        longBreakTimer: _longBreakTimer,
      ),
    );
  }
}
