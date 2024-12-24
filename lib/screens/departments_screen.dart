import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ошибка загрузки данных: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Нет данных о студентах'));
        }

        final students = snapshot.data!.docs;

        // Подсчет количества студентов по специальностям
        final Map<String, int> departmentCounts = {};

        for (var student in students) {
          // Приведение данных к Map<String, dynamic>
          final data = student.data() as Map<String, dynamic>?;

          // Проверяем наличие и корректность поля 'department'
          final departmentName = data?['department'];
          if (departmentName is String && departmentName.isNotEmpty) {
            departmentCounts[departmentName] =
                (departmentCounts[departmentName] ?? 0) + 1;
          }
        }

        if (departmentCounts.isEmpty) {
          return Center(child: Text('Нет данных о специальностях студентов'));
        }

        // Сортировка специальностей по алфавиту
        final sortedDepartments = departmentCounts.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));

        return ListView.builder(
          itemCount: sortedDepartments.length,
          itemBuilder: (ctx, index) {
            final entry = sortedDepartments[index];
            return ListTile(
              title: Text(entry.key), // Название специальности
              trailing: Text('${entry.value} студентов'), // Количество студентов
            );
          },
        );
      },
    );
  }
}
