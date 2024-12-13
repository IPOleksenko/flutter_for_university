import 'package:flutter/material.dart';
import '../model/student.dart';

class DepartmentsScreen extends StatelessWidget {
  final List<Student> students;

  DepartmentsScreen({required this.students});

  @override
  Widget build(BuildContext context) {
    final Map<Department, int> departmentCounts = {};

    for (var department in Department.values) {
      departmentCounts[department] = students.where((s) => s.department == department).length;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: Department.values.length,
        itemBuilder: (context, index) {
          final department = Department.values[index];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent.withOpacity(0.7),
                  Colors.blueAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  department.toString().split('.').last,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Students: ${departmentCounts[department] ?? 0}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
