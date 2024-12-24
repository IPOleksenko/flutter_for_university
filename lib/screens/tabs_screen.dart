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

  void _addStudent(Student newStudent) async {
    await FirebaseFirestore.instance.collection('students').add({
      'firstName': newStudent.firstName,
      'lastName': newStudent.lastName,
      'department': newStudent.department.name,
      'grade': newStudent.grade,
      'gender': newStudent.gender.name,
    });
  }

  void _deleteStudent(String id) async {
    await FirebaseFirestore.instance.collection('students').doc(id).delete();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showAddStudentDialog(BuildContext context) {
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    Department _selectedDepartment = Department.finance;
    Gender _selectedGender = Gender.male;
    int _grade = 1;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Add Student'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                DropdownButtonFormField<Department>(
                  value: _selectedDepartment,
                  decoration: InputDecoration(labelText: 'Department'),
                  items: Department.values
                      .map(
                        (dept) => DropdownMenuItem(
                      value: dept,
                      child: Text(dept.name),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    _selectedDepartment = value ?? Department.finance;
                  },
                ),
                DropdownButtonFormField<Gender>(
                  value: _selectedGender,
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: Gender.values
                      .map(
                        (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender.name),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    _selectedGender = value ?? Gender.male;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Grade'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _grade = int.tryParse(value) ?? 1;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newStudent = Student(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  department: _selectedDepartment,
                  gender: _selectedGender,
                  grade: _grade.toDouble(),
                );
                _addStudent(newStudent);
                Navigator.of(ctx).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> _pages = [
      {
        'page': StudentsScreen(
          onAddStudent: _addStudent,
          onDeleteStudent: _deleteStudent,
          departmentIcons: departmentIcons,
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
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
        onPressed: () => _showAddStudentDialog(context),
        child: Icon(Icons.add),
      )
          : null,
    );
  }
}
