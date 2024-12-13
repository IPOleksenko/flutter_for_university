import 'package:flutter/material.dart';
import '../widget/students.dart';
import 'departments_screen.dart';
import '../model/student.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Student> students = [
    Student(
      firstName: 'John',
      lastName: 'Doe',
      department: Department.it,
      grade: 85.0,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Jane',
      lastName: 'Smith',
      department: Department.finance,
      grade: 90.0,
      gender: Gender.female,
    ),
  ];

  void _addStudent(Student newStudent) {
    setState(() {
      students.add(newStudent);
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> _pages = [
      {
        'page': StudentsScreen(students: students, onAddStudent: _addStudent),
        'title': 'Students',
      },
      {
        'page': DepartmentsScreen(students: students),
        'title': 'Departments',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Departments',
          ),
        ],
      ),
    );
  }
}
