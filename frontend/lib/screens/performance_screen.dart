import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/screens/books_screen.dart';
import 'package:frontend/screens/previous_results.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:frontend/widgets/multipurpose_link_card.dart';
import 'package:frontend/widgets/performance_card.dart';
import 'package:provider/provider.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final userPerformance =
        Provider.of<PerformanceProvider>(context).performance;
    final double midPercentage =
        userPerformance.mid_scored / userPerformance.mid;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Performance"),
      ),
      body: Padding(
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
                  PerformanceCard(
                    percentage: midPercentage,
                    name: "Mid marks",
                    amount: userPerformance.mid_scored.toDouble(),
                  ),
                  PerformanceCard(
                    percentage: (userPerformance.cgpa / 10).toDouble(),
                    name: "CGPA",
                    amount: userPerformance.cgpa.toDouble(),
                  ),
                  PerformanceCard(
                    percentage: (userPerformance.backlogs).toDouble(),
                    name: "Backlogs",
                    amount: userPerformance.backlogs.toDouble(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: Text("These are your updates "),
            ),
            MultiPurposeCard(
              category: "Previous Results",
              height1: 100,
              screen: PreviousResults(),
            ),
            MultiPurposeLinkCard(category: "Eams Fee \n Paid", height1: 100),
          ],
        ),
      ),
    );
  }
}
