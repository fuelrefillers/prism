import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/screens/books_screen.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class BooksDepartmentScreen extends StatelessWidget {
  const BooksDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Departmens"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MultiPurposeCard(
              category: "CSE",
              height1: 80,
              screen: BooksScreen(category: "CSE"),
            ),
            MultiPurposeCard(
              category: "IT",
              height1: 80,
              screen: BooksScreen(category: "IT"),
            ),
            MultiPurposeCard(
              category: "EMERGING",
              height1: 80,
              screen: BooksScreen(category: "EMERGING"),
            ),
            MultiPurposeCard(
              category: "ECE",
              height1: 80,
              screen: BooksScreen(category: "ECE"),
            ),
            MultiPurposeCard(
              category: "EEE",
              height1: 80,
              screen: BooksScreen(category: "EEE"),
            ),
            MultiPurposeCard(
              category: "MECHANICAL",
              height1: 80,
              screen: BooksScreen(category: "MECHANICAL"),
            ),
            MultiPurposeCard(
              category: "CIVIL",
              height1: 80,
              screen: BooksScreen(category: "CIVIL"),
            ),
          ],
        ),
      ),
    );
  }
}
