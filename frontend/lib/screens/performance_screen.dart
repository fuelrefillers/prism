import 'package:flutter/material.dart';
import 'package:frontend/widgets/performance_card.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Performance"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PerformanceCard(),
                  PerformanceCard(),
                  PerformanceCard(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Text("These are your updates "),
            ),
          ],
        ),
      ),
    );
  }
}
