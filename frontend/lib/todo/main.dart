import 'package:flutter/material.dart';
import 'package:frontend/todo/screens/start_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: const StartScreen(),
  ));
}
