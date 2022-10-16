import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomofocus_app/view/content/components/alert_long_break_content.dart';
import 'package:pomofocus_app/view/content/components/alert_pomodoro_content.dart';
import 'package:pomofocus_app/view/content/components/alert_short_break_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandscapeMode extends StatefulWidget {
  int minutes;
  int seconds;
  bool pomodoroIsPressed;
  bool shortBreakIsPressed;
  bool longBreakIsPressed;
  bool startIsPressed;
  int pomodoroTimer;
  int shortBreakTimer;
  int longBreakTimer;

  LandscapeMode({
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
  State<LandscapeMode> createState() => _LandscapeModeState();
}

class _LandscapeModeState extends State<LandscapeMode> {
  final TextEditingController _pomodoroController = TextEditingController();
  final TextEditingController _shortBreakController = TextEditingController();
  final TextEditingController _longBreakController = TextEditingController();

  void playButtomSound() {
    final player = AudioCache();
    player.play('audio/button_click.mp3');
  }

  void playDigitalAlarm() {
    final player = AudioCache();
    player.play('audio/digital_alarm_beeping.mp3');
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                  size: height / 16,
                ),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Timer Settings'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            AlertPomodoro(
                              height: height / 10,
                              width: width / 15,
                              pomodoroController: _pomodoroController,
                              pomodoroTimer: widget.pomodoroTimer,
                            ),
                            AlertShortBreak(
                              height: height / 10,
                              width: width / 15,
                              shortBreakController: _shortBreakController,
                              shortBreakTimer: widget.shortBreakTimer,
                            ),
                            AlertLongBreak(
                              height: height / 10,
                              width: width / 15,
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
                          height: height / 15,
                          width: width / 15,
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: height / 1.7 - MediaQuery.of(context).padding.top,
                  width: height / 1.7,
                  child: Container(
                    height: height / 1.8,
                    width: height / 1.8,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${NumberFormat('00').format(widget.minutes)}:${NumberFormat('00').format(widget.seconds)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 5,
                          fontFamily: 'Arial Rounded',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      child: ElevatedButton(
                        child: Container(
                          width: width / 3,
                          height: height / 10,
                          alignment: Alignment.center,
                          child: const Text(
                            'Pomodoro',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: widget.pomodoroIsPressed == false ? 20 : 0,
                          shadowColor: Colors.black,
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
                    ),
                    ElevatedButton(
                      child: Container(
                        width: width / 3,
                        height: height / 10,
                        alignment: Alignment.center,
                        child: const Text(
                          'Short Break',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: widget.shortBreakIsPressed == false ? 20 : 0,
                        shadowColor: Colors.black,
                        primary: widget.shortBreakIsPressed == false
                            ? const Color.fromRGBO(255, 255, 255, 0.2)
                            : const Color.fromRGBO(116, 43, 40, 0.4),
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
                    Container(
                      padding: const EdgeInsets.all(7),
                      child: ElevatedButton(
                        child: Container(
                          width: width / 3,
                          height: height / 10,
                          alignment: Alignment.center,
                          child: const Text(
                            'Long Break',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation:
                              widget.longBreakIsPressed == false ? 20 : 0,
                          shadowColor: Colors.black,
                          primary: widget.longBreakIsPressed == false
                              ? const Color.fromRGBO(255, 255, 255, 0.2)
                              : const Color.fromRGBO(116, 43, 40, 0.4),
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
                    ),
                    Container(
                      padding: const EdgeInsets.all(7),
                      child: ElevatedButton(
                        child: Container(
                          width: width / 3,
                          height: height / 10,
                          alignment: Alignment.center,
                          child: Text(
                            widget.startIsPressed ? 'Pause' : 'Start',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromRGBO(217, 85, 80, 1),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: widget.startIsPressed == false ? 20 : 0,
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
                            Timer.periodic(const Duration(seconds: 1), (timer) {
                              if (widget.minutes > 0 && widget.seconds == 0) {
                                widget.seconds = 60;
                                widget.minutes--;
                              }
                              if ((widget.minutes == 0 &&
                                      widget.seconds == 0) ||
                                  widget.startIsPressed == false) {
                                timer.cancel();
                                widget.startIsPressed = false;
                                setState(() {});
                                playDigitalAlarm();
                              } else {
                                widget.seconds--;
                                setState(() {});
                              }
                            });
                          }
                          playButtomSound();
                        },
                      ),
                    ),
                    TextButton(
                      child: Container(
                        width: width / 3,
                        height: height / 18,
                        alignment: Alignment.center,
                        child: const Text(
                          'Reset',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
