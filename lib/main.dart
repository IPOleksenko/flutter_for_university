import 'package:flutter/material.dart';
import 'widget/students.dart'; // Import the StudentsScreen widget

void main() {
  runApp(ivanoleksenko_KIUKI_21_7());
}

class ivanoleksenko_KIUKI_21_7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentsScreen(), // Set the StudentsScreen as the home screen
    );
  }
}
