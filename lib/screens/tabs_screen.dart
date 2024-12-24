import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/student.dart';
import '../widget/students.dart';
import 'departments_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  bool _isLoading = false;

  void _addStudent(Student newStudent) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance.collection('students').add({
        'firstName': newStudent.firstName,
        'lastName': newStudent.lastName,
        'department': newStudent.department.name,
        'grade': newStudent.grade,
        'gender': newStudent.gender.name,
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding student: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deleteStudent(String id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance.collection('students').doc(id).delete();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting student: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
        'page': StudentsScreen(
          onAddStudent: _addStudent,
          onDeleteStudent: _deleteStudent,
          departmentIcons: departmentIcons, // Передача иконок в экран студентов
        ),
        'title': 'Students',
      },
      {
        'page': DepartmentsScreen(),
        'title': 'Departments',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pages[_selectedPageIndex]['page'] as Widget,
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
