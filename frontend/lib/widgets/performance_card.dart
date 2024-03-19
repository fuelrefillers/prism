import 'package:flutter/material.dart';
import 'package:frontend/widgets/linear_progress_bar.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({
    super.key,
    required this.name,
    required this.percentage,
    required this.amount,
  });
  final String name;
  final double percentage;
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      height: MediaQuery.of(context).size.height / 5.9,
      width: MediaQuery.of(context).size.width / 2.7,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Text(
                amount.toString(),
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Stack(
                children: [
                  LinearProgressBar(
                    progressPer: percentage,
                    barcolor: Color.fromARGB(255, 17, 79, 90),
                  ),
                  Center(
                      child: Text(
                    "",
                    style: TextStyle(fontSize: 22),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
