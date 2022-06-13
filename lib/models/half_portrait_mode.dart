import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/content/components/alert_long_break_content.dart';
import '../view/content/components/alert_pomodoro_content.dart';
import '../view/content/components/alert_short_break_content.dart';

class HalfPortraitMode extends StatefulWidget {
  int minutes;
  int seconds;
  bool pomodoroIsPressed;
  bool shortBreakIsPressed;
  bool longBreakIsPressed;
  bool startIsPressed;
  int pomodoroTimer;
  int shortBreakTimer;
  int longBreakTimer;

  HalfPortraitMode({
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
  State<HalfPortraitMode> createState() => _HalfPortraitModeState();
}

class _HalfPortraitModeState extends State<HalfPortraitMode> {
  final TextEditingController _pomodoroController = TextEditingController();
  final TextEditingController _shortBreakController = TextEditingController();
  final TextEditingController _longBreakController = TextEditingController();

  int increment(int value) {
    return value + 1;
  }

  int decrement(int value) {
    if (value > 0) {
      return value - 1;
    }
    return 0;
  }

  _updateTime(int pomodoro, int shortBreak, int longBreak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pomodoro', pomodoro);
    await prefs.setInt('shortBreak', shortBreak);
    await prefs.setInt('longBreak', longBreak);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _pomodoroController.text = widget.pomodoroTimer.toString();
    _shortBreakController.text = widget.shortBreakTimer.toString();
    _longBreakController.text = widget.longBreakTimer.toString();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 85, 80, 1),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: height / 30,
                ),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Timer Settings'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AlertPomodoro(
                              height: height / 10,
                              width: width / 8,
                              pomodoroController: _pomodoroController,
                              pomodoroTimer: widget.pomodoroTimer,
                            ),
                            AlertShortBreak(
                              height: height / 10,
                              width: width / 8,
                              shortBreakController: _shortBreakController,
                              shortBreakTimer: widget.shortBreakTimer,
                            ),
                            AlertLongBreak(
                              height: height / 10,
                              width: width / 8,
                              longBreakController: _longBreakController,
                              longBreakTimer: widget.longBreakTimer,
                            )
                          ],
                        )
                      ],
                    ),
                    backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
                    actions: <Widget>[
                      TextButton(
                        child: Container(
                          height: height / 12,
                          width: width / 10,
                          alignment: Alignment.center,
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arial Rounded',
                            ),
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(34, 34, 34, 1),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        onPressed: () {
                          widget.pomodoroTimer =
                              int.parse(_pomodoroController.text);
                          widget.shortBreakTimer =
                              int.parse(_shortBreakController.text);
                          widget.longBreakTimer =
                              int.parse(_longBreakController.text);

                          if (widget.pomodoroIsPressed) {
                            widget.minutes = widget.pomodoroTimer;
                          }
                          if (widget.shortBreakIsPressed) {
                            widget.minutes = widget.shortBreakTimer;
                          }
                          if (widget.longBreakIsPressed) {
                            widget.minutes = widget.longBreakTimer;
                          }

                          _updateTime(
                            widget.pomodoroTimer,
                            widget.shortBreakTimer,
                            widget.longBreakTimer,
                          );

                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            height: height / 1.5,
            width: width / 1.2,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: height / 6),
                  child: Text(
                    '${NumberFormat('00').format(widget.minutes)}:${NumberFormat('00').format(widget.seconds)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 8,
                      fontFamily: 'Arial Rounded',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text(
                              'Pomodoro',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: widget.pomodoroIsPressed
                                  ? const Color.fromRGBO(116, 43, 40, 0.4)
                                  : const Color.fromRGBO(255, 255, 255, 0.2),
                            ),
                            onPressed: () {
                              if (widget.pomodoroIsPressed) {
                                widget.pomodoroIsPressed = false;
                              } else {
                                widget.minutes =
                                    int.parse(_pomodoroController.text);
                                widget.seconds = 0;
                                widget.pomodoroIsPressed = true;
                                widget.shortBreakIsPressed = false;
                                widget.longBreakIsPressed = false;
                              }
                              setState(() {});
                            },
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Short Break',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: widget.shortBreakIsPressed
                                  ? const Color.fromRGBO(116, 43, 40, 0.4)
                                  : const Color.fromRGBO(255, 255, 255, 0.2),
                            ),
                            onPressed: () {
                              if (widget.shortBreakIsPressed) {
                                widget.shortBreakIsPressed = false;
                              } else {
                                widget.minutes =
                                    int.parse(_shortBreakController.text);
                                widget.seconds = 0;
                                widget.shortBreakIsPressed = true;
                                widget.pomodoroIsPressed = false;
                                widget.longBreakIsPressed = false;
                              }
                              setState(() {});
                            },
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Long Break',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: widget.longBreakIsPressed
                                  ? const Color.fromRGBO(116, 43, 40, 0.4)
                                  : const Color.fromRGBO(255, 255, 255, 0.2),
                            ),
                            onPressed: () {
                              if (widget.longBreakIsPressed) {
                                widget.longBreakIsPressed = false;
                              } else {
                                widget.minutes =
                                    int.parse(_longBreakController.text);
                                widget.seconds = 0;
                                widget.longBreakIsPressed = true;
                                widget.pomodoroIsPressed = false;
                                widget.shortBreakIsPressed = false;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 7, bottom: 20),
                          child: ElevatedButton(
                            child: Text(
                              widget.startIsPressed ? 'Pause' : 'Start',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromRGBO(217, 85, 80, 1),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation:
                                  widget.startIsPressed == false ? 20 : 0,
                              shadowColor: Colors.white,
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              if (widget.startIsPressed) {
                                setState(() {
                                  widget.startIsPressed = false;
                                  if (widget.seconds == 60) {
                                    widget.seconds = 59;
                                  }
                                });
                              } else {
                                widget.startIsPressed = true;
                                Timer.periodic(const Duration(seconds: 1),
                                    (timer) {
                                  if (widget.minutes > 0 &&
                                      widget.seconds == 0) {
                                    widget.seconds = 60;
                                    widget.minutes--;
                                  }
                                  if ((widget.minutes == 0 &&
                                          widget.seconds == 0) ||
                                      widget.startIsPressed == false) {
                                    timer.cancel();
                                    widget.startIsPressed = false;
                                    setState(() {});
                                  } else {
                                    widget.seconds--;
                                    setState(() {});
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 7, bottom: 20),
                          child: TextButton(
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (widget.pomodoroIsPressed) {
                                widget.minutes = widget.pomodoroTimer;
                                widget.seconds = 0;
                              }
                              if (widget.shortBreakIsPressed) {
                                widget.minutes = widget.shortBreakTimer;
                                widget.seconds = 0;
                              }
                              if (widget.longBreakIsPressed) {
                                widget.minutes = widget.longBreakTimer;
                                widget.seconds = 0;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
