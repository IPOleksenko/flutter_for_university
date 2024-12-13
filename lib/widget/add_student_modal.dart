import 'package:flutter/material.dart';
import '../model/student.dart';

class AddStudentModal extends StatefulWidget {
  @override
  _AddStudentModalState createState() => _AddStudentModalState();
}

class _AddStudentModalState extends State<AddStudentModal> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  Department department = Department.it;
  Gender gender = Gender.male;
  double grade = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              onSaved: (value) => firstName = value ?? '',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              onSaved: (value) => lastName = value ?? '',
            ),
            DropdownButtonFormField<Department>(
              value: department,
              items: Department.values
                  .map((d) => DropdownMenuItem(value: d, child: Text(d.toString().split('.').last)))
                  .toList(),
              onChanged: (value) => department = value!,
            ),
            DropdownButtonFormField<Gender>(
              value: gender,
              items: Gender.values
                  .map((g) => DropdownMenuItem(value: g, child: Text(g.toString().split('.').last)))
                  .toList(),
              onChanged: (value) => gender = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Grade'),
              keyboardType: TextInputType.number,
              onSaved: (value) => grade = double.tryParse(value ?? '0.0') ?? 0.0,
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState?.save();
                Navigator.of(context).pop(
                  Student(
                    firstName: firstName,
                    lastName: lastName,
                    department: department,
                    grade: grade,
                    gender: gender,
                  ),
                );
              },
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
