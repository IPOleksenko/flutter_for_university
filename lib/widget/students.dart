import 'package:flutter/material.dart';
import '../model/student.dart';
import 'student_item.dart';
import 'add_student_modal.dart';

class StudentsScreen extends StatelessWidget {
  final List<Student> students;
  final Function(Student) onAddStudent;

  StudentsScreen({required this.students, required this.onAddStudent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await showModalBottomSheet<Student>(
                context: context,
                builder: (_) => AddStudentModal(),
              );
              if (result != null) {
                onAddStudent(result);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => StudentItem(student: students[index]),
      ),
    );
  }
}
