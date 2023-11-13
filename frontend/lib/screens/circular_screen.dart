import 'package:flutter/material.dart';
import 'package:frontend/screens/books_screen.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class Circulars extends StatelessWidget {
  const Circulars({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circular"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MultiPurposeCard(
              category: "Diwali Holiday Circular \nDate:13/10/23",
              height1: 100.0,
              screen: BooksScreen(
                  category: "Diwali Holiday Circular \nDate:13/10/23"),
            ),
            MultiPurposeCard(
              category: "Christamas Holiday Circular \nDate:25/12/2023 ",
              height1: 100.0,
              screen: BooksScreen(
                  category: "Diwali Holiday Circular \nDate:13/10/23"),
            ),
            Text(
              "going to be deleted in 3 days...",
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
