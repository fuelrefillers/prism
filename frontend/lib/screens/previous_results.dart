import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/screens/books_screen.dart';
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
        itemCount: userPerformance.previous_cgpa.length,
        itemBuilder: (context, index) => MultiPurposeCard(
          category:
              "${userPerformance.previous_cgpa[index]} SGPA \nsem ${index + 1}",
          height1: 100,
          screen: BooksScreen(category: "sem ${index + 1}"),
        ),
      ),
    );
  }
}
