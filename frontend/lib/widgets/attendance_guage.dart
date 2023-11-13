import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class AttendanceGuage extends StatelessWidget {
  const AttendanceGuage({super.key, required this.totalAttendance});
  final double totalAttendance;
  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      initialValue: 0.0,
      duration: Duration(seconds: 2),
      curve: Curves.elasticOut,
      radius: 100,
      value: totalAttendance * 100,
      axis: GaugeAxis(
        min: 0,
        max: 100,
        degrees: 180,
        style: GaugeAxisStyle(
          thickness: 20,
          background: Color.fromARGB(255, 0, 0, 0),
          segmentSpacing: 4,
        ),
        progressBar:
            GaugeProgressBar.rounded(color: Color.fromARGB(0, 255, 255, 255)),
        segments: [
          GaugeSegment(
            from: 0,
            to: 50,
            color: Color.fromARGB(255, 255, 0, 0),
            cornerRadius: Radius.zero,
          ),
          GaugeSegment(
            from: 50,
            to: 75,
            color: Color.fromARGB(255, 255, 126, 62),
            cornerRadius: Radius.zero,
          ),
          GaugeSegment(
            from: 75,
            to: 100,
            color: Color.fromARGB(255, 38, 243, 11),
            cornerRadius: Radius.zero,
          ),
        ],
      ),
    );
  }
}
