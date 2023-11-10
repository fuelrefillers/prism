import 'dart:async';

import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {
  const LinearProgressBar({super.key});
  @override
  State<LinearProgressBar> createState() {
    return _LinearProgressBarState();
  }
}

class _LinearProgressBarState extends State<LinearProgressBar> {
  double value = 0;
  double givenval = 0.5;
  @override
  void initState() {
    super.initState();
    determinateIndicator();
  }

  void determinateIndicator() {
    Timer.periodic(const Duration(milliseconds: 25), (Timer timer) {
      setState(() {
        if (value.toStringAsFixed(2) == givenval.toStringAsFixed(2)) {
          timer.cancel();
          print(value.toStringAsFixed(1));
        } else {
          value = value + 0.01;
          print(value.toStringAsFixed(1));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Color.fromARGB(54, 64, 195, 255),
      color: Colors.red,
      minHeight: 25,
      value: value,
      borderRadius: BorderRadius.circular(5),
    );
  }
}
