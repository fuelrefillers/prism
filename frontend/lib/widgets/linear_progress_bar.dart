import 'dart:async';

import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {
  const LinearProgressBar(
      {super.key, required this.progressPer, required this.barcolor});
  final double progressPer;
  final Color barcolor;
  @override
  State<LinearProgressBar> createState() {
    return _LinearProgressBarState();
  }
}

class _LinearProgressBarState extends State<LinearProgressBar> {
  double value = 0;
  @override
  void initState() {
    super.initState();
    determinateIndicator();
  }

  void determinateIndicator() {
    Timer.periodic(const Duration(milliseconds: 15), (Timer timer) {
      setState(() {
        if (value.toStringAsFixed(2) == widget.progressPer.toStringAsFixed(2)) {
          timer.cancel();
        } else {
          value = value + 0.01;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Color.fromARGB(255, 217, 217, 217),
      valueColor: AlwaysStoppedAnimation<Color>(widget.barcolor),
      minHeight: 25,
      value: value,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
