import 'package:flutter/material.dart';
import 'package:frontend/widgets/backlogs_card.dart';

class BacklogsScreen extends StatelessWidget {
  const BacklogsScreen({super.key, required this.backlogs});
  final List<dynamic> backlogs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Backlogs")),
      body: ListView.builder(
          itemCount: backlogs.length,
          itemBuilder: (context, index) =>
              BacklogsCard(category: backlogs[index])),
    );
  }
}
