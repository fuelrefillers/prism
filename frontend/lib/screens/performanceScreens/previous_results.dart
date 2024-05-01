import 'package:flutter/material.dart';
import 'package:frontend/providers/performance_provider.dart';
import 'package:frontend/screens/performanceScreens/sem_marks_screen.dart';
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
        elevation: 1,
        shadowColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Previous Results"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: userPerformance.PreviousSGPA.length,
        itemBuilder: (context, index) => MultiPurposeCard(
          category: "Semester ${index + 1}",
          height1: MediaQuery.of(context).size.height / 7.9,
          screen: SemMarksScreen(
            name: "SEM ${index + 1} ",
            RollNo: userPerformance.RollNo,
          ),
          subcategory: "SGPA : ${userPerformance.PreviousSGPA[index]}",
          subcategory1: '',
        ),
      ),
    );
  }
}
