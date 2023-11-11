import 'package:flutter/material.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class BooksHomeScreen extends StatelessWidget {
  const BooksHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MultiPurposeCard(category: "CSE"),
            MultiPurposeCard(category: "IT"),
            MultiPurposeCard(category: "EMERGING"),
            MultiPurposeCard(category: "ECE"),
            MultiPurposeCard(category: "EEE"),
            MultiPurposeCard(category: "MECHANICAL"),
            MultiPurposeCard(category: "CIVIL"),
          ],
        ),
      ),
    );
  }
}
