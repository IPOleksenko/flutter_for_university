import 'package:flutter/material.dart';
import '../model/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  StudentItem({required this.student});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(departmentIcons[student.department] ?? ''),
      title: Text('${student.firstName} ${student.lastName}'),
      subtitle: Text('Grade: ${student.grade}'),
      tileColor: student.gender == Gender.male ? Colors.blue[100] : Colors.pink[100],
    );
  }
}
