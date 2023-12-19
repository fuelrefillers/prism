import 'package:flutter/material.dart';
import 'package:frontend/screens/books_department_screen.dart';
import 'package:frontend/screens/books_downloaded_screen.dart';
import 'package:frontend/screens/books_screen.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class BooksHomeScreen extends StatefulWidget {
  const BooksHomeScreen({super.key});

  @override
  State<BooksHomeScreen> createState() => _BooksHomeScreenState();
}

class _BooksHomeScreenState extends State<BooksHomeScreen> {
  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  final List<Widget> _screens = [
    BooksDepartmentScreen(),
    BooksDownloadedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          currentIndex: _selectedScreenIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Departments"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: "Downloaded"),
          ]),
    );
  }
}
