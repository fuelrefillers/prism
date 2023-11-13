import 'package:flutter/material.dart';
import 'package:frontend/screens/books_screen.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:frontend/widgets/multipurpose_link_card.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tables"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MultiPurposeLinkCard(category: "CSE", height1: 80),
            MultiPurposeLinkCard(category: "IT", height1: 80),
            MultiPurposeLinkCard(category: "EMERGING", height1: 80),
            MultiPurposeLinkCard(category: "ECE", height1: 80),
            MultiPurposeLinkCard(category: "EEE", height1: 80),
            MultiPurposeLinkCard(category: "MECHANICAL", height1: 80),
            MultiPurposeLinkCard(category: "CIVIL", height1: 80),
            MultiPurposeLinkCard(category: "CIVIL", height1: 80),
            MultiPurposeLinkCard(category: "MINING", height1: 80),
          ],
        ),
      ),
    );
  }
}
