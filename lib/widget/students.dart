import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/student.dart';

class StudentsScreen extends StatelessWidget {
  final Function(Student) onAddStudent;
  final Function(String) onDeleteStudent;
  final Map<Department, String> departmentIcons;

  StudentsScreen({
    required this.onAddStudent,
    required this.onDeleteStudent,
    required this.departmentIcons,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading students data'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No students found'));
        }

        final students = snapshot.data!.docs;

        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (ctx, index) {
            final studentData = students[index];
            final department = Department.values.firstWhere(
                  (dept) => dept.name == studentData['department'],
              orElse: () => Department.finance, // Значение по умолчанию
            );

            return ListTile(
              leading: Text(
                departmentIcons[department] ?? '',
                style: TextStyle(fontSize: 24),
              ),
              title: Text(
                '${studentData['firstName']} ${studentData['lastName']}',
              ),
              subtitle: Text('Grade: ${studentData['grade']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onDeleteStudent(studentData.id),
              ),
            );
          },
        );
      },
    );
  }
}
