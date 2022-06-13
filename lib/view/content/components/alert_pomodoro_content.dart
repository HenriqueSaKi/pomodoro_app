import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlertPomodoro extends StatefulWidget {
  double height;
  double width;
  TextEditingController pomodoroController;
  int pomodoroTimer;

  AlertPomodoro({
    Key? key,
    required this.height,
    required this.width,
    required this.pomodoroController,
    required this.pomodoroTimer,
  }) : super(key: key);

  @override
  State<AlertPomodoro> createState() => _AlertPomodoroState();
}

class _AlertPomodoroState extends State<AlertPomodoro> {
  int increment(int value) {
    return value + 1;
  }

  int decrement(int value) {
    if (value > 1) {
      return value - 1;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Pomodoro',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Arial Rounded',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 2, bottom: 10),
              alignment: Alignment.center,
              height: widget.height,
              width: widget.width,
              child: ElevatedButton(
                child: const Icon(
                  Icons.remove,
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(34, 34, 34, 1),
                ),
                onPressed: () {
                  setState(() {
                    widget.pomodoroTimer = decrement(widget.pomodoroTimer);
                    widget.pomodoroController.text =
                        widget.pomodoroTimer.toString();
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, bottom: 5),
              height: widget.height,
              width: widget.width,
              child: TextField(
                textAlign: TextAlign.center,
                controller: widget.pomodoroController,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontFamily: 'Arial Rounded',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, bottom: 10),
              alignment: Alignment.center,
              height: widget.height,
              width: widget.width,
              child: ElevatedButton(
                child: const Icon(
                  Icons.add,
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(34, 34, 34, 1),
                ),
                onPressed: () {
                  setState(() {
                    widget.pomodoroTimer = increment(widget.pomodoroTimer);
                    widget.pomodoroController.text =
                        widget.pomodoroTimer.toString();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
