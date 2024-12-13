import 'package:flutter/material.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabsScreen(),
    );
  }
}
