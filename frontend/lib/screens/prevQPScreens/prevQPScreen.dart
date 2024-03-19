import 'package:flutter/material.dart';
import 'package:frontend/screens/prevQPScreens/downloaded_prevQp.dart';
import 'package:frontend/screens/prevQPScreens/prevQP.dart';

class PrevQPViewScreen extends StatefulWidget {
  const PrevQPViewScreen({super.key});

  @override
  State<PrevQPViewScreen> createState() => _PrevQPViewScreenState();
}

class _PrevQPViewScreenState extends State<PrevQPViewScreen> {
  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  final List<Widget> _screens = [
    PrevQPScreen(),
    PrevQPDownloadedScreen(),
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
                icon: Icon(Icons.category), label: "PrevQP"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: "Downloaded"),
          ]),
    );
  }
}
