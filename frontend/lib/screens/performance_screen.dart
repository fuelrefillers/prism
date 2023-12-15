import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/screens/backlogs_screen.dart';
import 'package:frontend/screens/performance_graph.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    double midPercentage = 0;
    List<double> midsR = [];
    List<double> semR = [];
    final List<Feature> features1 = [];
    final List<Feature> features2 = [];
    final userPerformance =
        Provider.of<PerformanceProvider>(context).performance;
    if (userPerformance.MidTotal.isNotEmpty) {
      midPercentage =
          userPerformance.MidScored.last / userPerformance.MidTotal.last;
      for (var i = 0; i < userPerformance.MidScored.length; i++) {
        midsR.add(userPerformance.MidScored[i] / userPerformance.MidTotal[i]);
      }
      for (var i = 0; i < userPerformance.MidScored.length; i++) {
        semR.add(userPerformance.PreviousSGPA[i] / 10);
      }
      features1
          .add(Feature(title: "Mid Marks", color: Colors.blue, data: midsR));
      features2.add(Feature(
          title: "Sem Marks",
          color: const Color.fromARGB(255, 110, 33, 243),
          data: semR));
    } else {
      midPercentage = 0;
    }

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
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PerformanceGraphScreen(
                                    fromData: features1,
                                    category: 'Mid',
                                    name: 'Mid Analysis',
                                    length: midsR.length,
                                  )));
                    },
                    child: PerformanceCardB(
                      percentage: midPercentage,
                      name: "Mid marks",
                      amount: userPerformance.MidScored.last,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PerformanceGraphScreen(
                                    fromData: features2,
                                    category: 'Sem',
                                    name: 'Sem Analysis',
                                    length: semR.length,
                                  )));
                    },
                    child: PerformanceCard(
                      percentage: double.parse(userPerformance.CGPA) / 10,
                      name: "CGPA",
                      amount: double.parse(userPerformance.CGPA),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BacklogsScreen(
                                  backlogs: userPerformance.Backlogs)));
                    },
                    child: PerformanceCardB(
                      percentage: userPerformance.Backlogs.length /
                          userPerformance.TotalSub,
                      name: "Backlogs",
                      amount: userPerformance.Backlogs.length,
                    ),
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
            MultiPurposeLinkCard(category: "Exams Fee \n Paid", height1: 100),
          ],
        ),
      ),
    );
  }
}
