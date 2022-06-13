import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlertShortBreak extends StatefulWidget {
  double height;
  double width;
  TextEditingController shortBreakController;
  int shortBreakTimer;

  AlertShortBreak({
    Key? key,
    required this.height,
    required this.width,
    required this.shortBreakController,
    required this.shortBreakTimer,
  }) : super(key: key);

  @override
  State<AlertShortBreak> createState() => _AlertShortBreakState();
}

class _AlertShortBreakState extends State<AlertShortBreak> {
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
          'Short Break',
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
                    widget.shortBreakTimer = decrement(widget.shortBreakTimer);
                    widget.shortBreakController.text =
                        widget.shortBreakTimer.toString();
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
                readOnly: true,
                controller: widget.shortBreakController,
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
                    widget.shortBreakTimer = increment(widget.shortBreakTimer);
                    widget.shortBreakController.text =
                        widget.shortBreakTimer.toString();
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
