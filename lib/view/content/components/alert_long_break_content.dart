import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlertLongBreak extends StatefulWidget {
  double height;
  double width;
  TextEditingController longBreakController;
  int longBreakTimer;

  AlertLongBreak({
    Key? key,
    required this.height,
    required this.width,
    required this.longBreakController,
    required this.longBreakTimer,
  }) : super(key: key);

  @override
  State<AlertLongBreak> createState() => _AlertLongBreakState();
}

class _AlertLongBreakState extends State<AlertLongBreak> {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Text(
          'Long Break',
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
                    widget.longBreakTimer = decrement(widget.longBreakTimer);
                    widget.longBreakController.text =
                        widget.longBreakTimer.toString();
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
                controller: widget.longBreakController,
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
                    widget.longBreakTimer = increment(widget.longBreakTimer);
                    widget.longBreakController.text =
                        widget.longBreakTimer.toString();
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
