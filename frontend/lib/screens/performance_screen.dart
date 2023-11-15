import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/screens/previous_results.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:frontend/widgets/multipurpose_link_card.dart';
import 'package:frontend/widgets/one_more_performance_card.dart';
import 'package:frontend/widgets/performance_card.dart';
import 'package:provider/provider.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final Authservice authService = Authservice();

  @override
  void initState() {
    super.initState();
    authService.getPerformance(context);
  }

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
                  PerformanceCardB(
                    percentage: midPercentage,
                    name: "Mid marks",
                    amount: userPerformance.mid_scored,
                  ),
                  PerformanceCard(
                    percentage: (userPerformance.cgpa / 10).toDouble(),
                    name: "CGPA",
                    amount: userPerformance.cgpa,
                  ),
                  PerformanceCardB(
                    percentage: (userPerformance.backlogs).toDouble(),
                    name: "Backlogs",
                    amount: userPerformance.backlogs,
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
