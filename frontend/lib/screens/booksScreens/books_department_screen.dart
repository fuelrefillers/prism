import 'package:flutter/material.dart';
import 'package:frontend/screens/booksScreens/books_screen.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class BooksDepartmentScreen extends StatelessWidget {
  const BooksDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Departments"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MultiPurposeCard(
              category: "CSE",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "CSE"),
              subcategory: '',
              subcategory1: '',
            ),
            MultiPurposeCard(
              category: "IT",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "IT"),
              subcategory: '',
              subcategory1: '',
            ),
            MultiPurposeCard(
              category: "EMERGING",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "EMERGING"),
              subcategory: '',
              subcategory1: '',
            ),
            MultiPurposeCard(
              category: "ECE",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "ECE"),
              subcategory: '',
              subcategory1: '',
            ),
            MultiPurposeCard(
              category: "EEE",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "EEE"),
              subcategory: '',
              subcategory1: '',
            ),
            MultiPurposeCard(
              category: "MECHANICAL",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "MECHANICAL"),
              subcategory: '',
              subcategory1: '',
            ),
            MultiPurposeCard(
              category: "CIVIL",
              height1: MediaQuery.of(context).size.height / 12,
              screen: BooksScreen(category: "CIVIL"),
              subcategory: '',
              subcategory1: '',
            ),
          ],
        ),
      ),
    );
  }
}
