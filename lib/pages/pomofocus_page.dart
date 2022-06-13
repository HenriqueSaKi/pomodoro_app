import 'package:flutter/material.dart';
import 'package:pomofocus_app/models/half_portrait_mode.dart';
import 'package:pomofocus_app/models/portrait_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/landscape_mode.dart';

class PomofocusPage extends StatefulWidget {
  int minutes;
  int seconds;
  bool pomodoroIsPressed;
  bool shortBreakIsPressed;
  bool longBreakIsPressed;
  bool startIsPressed;
  int pomodoroTimer;
  int shortBreakTimer;
  int longBreakTimer;

  PomofocusPage({
    Key? key,
    required this.minutes,
    required this.seconds,
    required this.pomodoroIsPressed,
    required this.shortBreakIsPressed,
    required this.longBreakIsPressed,
    required this.startIsPressed,
    required this.pomodoroTimer,
    required this.shortBreakTimer,
    required this.longBreakTimer,
  }) : super(key: key);

  @override
  State<PomofocusPage> createState() => _PomofocusPageState();
}

class _PomofocusPageState extends State<PomofocusPage> {
  @override
  void initState() {
    _setInitTime();
    super.initState();
  }

  _setInitTime() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('pomodoro') != null) {
      widget.pomodoroTimer = int.parse(prefs.getInt('pomodoro').toString());
    }
    if (prefs.getInt('shortBreak') != null) {
      widget.shortBreakTimer = int.parse(prefs.getInt('shortBreak').toString());
    }
    if (prefs.getInt('longBreak') != null) {
      widget.longBreakTimer = int.parse(prefs.getInt('longBreak').toString());
    }
    widget.minutes = widget.pomodoroTimer;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (height > 750 && width > 750) {
      return Container(
        color: Colors.purple,
      );
    } else if (height < 700 && width < 550) {
      return HalfPortraitMode(
        minutes: widget.minutes,
        seconds: widget.seconds,
        pomodoroIsPressed: widget.pomodoroIsPressed,
        shortBreakIsPressed: widget.shortBreakIsPressed,
        longBreakIsPressed: widget.longBreakIsPressed,
        startIsPressed: widget.startIsPressed,
        pomodoroTimer: widget.pomodoroTimer,
        shortBreakTimer: widget.shortBreakTimer,
        longBreakTimer: widget.longBreakTimer,
      );
    } else {
      return OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? PortraitMode(
                  minutes: widget.minutes,
                  seconds: widget.seconds,
                  pomodoroIsPressed: widget.pomodoroIsPressed,
                  shortBreakIsPressed: widget.shortBreakIsPressed,
                  longBreakIsPressed: widget.longBreakIsPressed,
                  startIsPressed: widget.startIsPressed,
                  pomodoroTimer: widget.pomodoroTimer,
                  shortBreakTimer: widget.shortBreakTimer,
                  longBreakTimer: widget.longBreakTimer,
                )
              : LandscapeMode(
                  minutes: widget.minutes,
                  seconds: widget.seconds,
                  pomodoroIsPressed: widget.pomodoroIsPressed,
                  shortBreakIsPressed: widget.shortBreakIsPressed,
                  longBreakIsPressed: widget.longBreakIsPressed,
                  startIsPressed: widget.startIsPressed,
                  pomodoroTimer: widget.pomodoroTimer,
                  shortBreakTimer: widget.shortBreakTimer,
                  longBreakTimer: widget.longBreakTimer,
                );
        },
      );
    }
  }
}
