import 'package:flutter/material.dart';

class BacklogsCard extends StatelessWidget {
  const BacklogsCard({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(category),
          ),
        ),
      ),
    );
  }
}
