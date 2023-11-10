import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/widgets/linear_progress_bar.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      height: 150,
      width: 150,
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Mid marks :",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Text(
                "500",
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Stack(
                children: [
                  LinearProgressBar(),
                  Center(
                      child: Text(
                    "50%",
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
