import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/screens/sem_marks_screen.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:provider/provider.dart';

class PreviousResults extends StatelessWidget {
  const PreviousResults({super.key});
  @override
  Widget build(BuildContext context) {
    final userPerformance =
        Provider.of<PerformanceProvider>(context).performance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Results"),
      ),
      body: ListView.builder(
        itemCount: userPerformance.PreviousSGPA.length,
        itemBuilder: (context, index) => MultiPurposeCard(
          category:
              "sem ${index + 1} \n SGPA : ${userPerformance.PreviousSGPA[index]}",
          height1: 100,
          screen: SemMarksScreen(
            name: "SEM ${index + 1} ",
            RollNo: userPerformance.RollNo,
          ),
        ),
      ),
    );
  }
}
