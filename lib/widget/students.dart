import 'package:flutter/material.dart';
import '../model/student.dart';
import 'student_item.dart';

// The main screen that shows a list of students
class StudentsScreen extends StatelessWidget {
  List<Student> students = [
    Student(
      firstName: 'John',
      lastName: 'Doe',
      department: Department.it,
      grade: 85,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Jane',
      lastName: 'Smith',
      department: Department.finance,
      grade: 90,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Emily',
      lastName: 'Johnson',
      department: Department.finance,
      grade: 88,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Michael',
      lastName: 'Brown',
      department: Department.it,
      grade: 92,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Emma',
      lastName: 'Davis',
      department: Department.finance,
      grade: 75,
      gender: Gender.female,
    ),
    Student(
      firstName: 'James',
      lastName: 'Wilson',
      department: Department.law,
      grade: 78,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Olivia',
      lastName: 'Garcia',
      department: Department.medical,
      grade: 95,
      gender: Gender.female,
    ),
    Student(
      firstName: 'William',
      lastName: 'Martinez',
      department: Department.law,
      grade: 82,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Ava',
      lastName: 'Hernandez',
      department: Department.finance,
      grade: 89,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Sophia',
      lastName: 'Lopez',
      department: Department.medical,
      grade: 91,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Liam',
      lastName: 'Thompson',
      department: Department.it,
      grade: 86,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Mia',
      lastName: 'Martinez',
      department: Department.medical,
      grade: 94,
      gender: Gender.female,
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
