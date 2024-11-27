import 'package:flutter/material.dart';

enum Department { it, finance, marketing }
enum Gender { male, female }

class Student {
  final String firstName;
  final String lastName;
  final Department department;
  final double grade; // Оценка как double
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> students = [
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
    Student(
      firstName: 'Emily',
      lastName: 'Johnson',
      department: Department.finance,
      grade: 88.5,
      gender: Gender.female,
    ),
  ];

  Student? recentlyDeletedStudent;
  int? recentlyDeletedIndex;

  void _addStudent() async {
    final result = await showModalBottomSheet<Student>(
      context: context,
      builder: (context) {
        return AddStudentModal();
      },
    );

    if (result != null) {
      setState(() {
        students.add(result);
      });
    }
  }

  void _editStudent(int index) async {
    final result = await showModalBottomSheet<Student>(
      context: context,
      builder: (context) {
        return AddStudentModal(existingStudent: students[index]);
      },
    );

    if (result != null) {
      setState(() {
        students[index] = result;
      });
    }
  }

  void _deleteStudent(int index) {
    setState(() {
      recentlyDeletedStudent = students[index];
      recentlyDeletedIndex = index;
      students.removeAt(index);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${recentlyDeletedStudent!.firstName} удален'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                students.insert(recentlyDeletedIndex!, recentlyDeletedStudent!);
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addStudent,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(students[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => _deleteStudent(index),
            child: ListTile(
              title: Text('${students[index].firstName} ${students[index].lastName}'),
              subtitle: Text('Grade: ${students[index].grade}'),
              onTap: () => _editStudent(index),
            ),
          );
        },
      ),
    );
  }
}

class AddStudentModal extends StatefulWidget {
  final Student? existingStudent;

  AddStudentModal({this.existingStudent});

  @override
  _AddStudentModalState createState() => _AddStudentModalState();
}

class _AddStudentModalState extends State<AddStudentModal> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late Department department;
  late double grade;
  late Gender gender;

  @override
  void initState() {
    super.initState();
    if (widget.existingStudent != null) {
      firstName = widget.existingStudent!.firstName;
      lastName = widget.existingStudent!.lastName;
      department = widget.existingStudent!.department;
      grade = widget.existingStudent!.grade;
      gender = widget.existingStudent!.gender;
    } else {
      firstName = '';
      lastName = '';
      department = Department.it;
      grade = 0.0;
      gender = Gender.male;
    }
  }

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
              initialValue: firstName,
              decoration: InputDecoration(labelText: 'First Name'),
              validator: (value) => value!.isEmpty ? 'Enter a first name' : null,
              onSaved: (value) => firstName = value!,
            ),
            TextFormField(
              initialValue: lastName,
              decoration: InputDecoration(labelText: 'Last Name'),
              validator: (value) => value!.isEmpty ? 'Enter a last name' : null,
              onSaved: (value) => lastName = value!,
            ),
            DropdownButtonFormField<Department>(
              value: department,
              items: Department.values
                  .map((dept) => DropdownMenuItem(
                value: dept,
                child: Text(dept.toString().split('.').last),
              ))
                  .toList(),
              onChanged: (value) => department = value!,
            ),
            TextFormField(
              initialValue: grade.toString(),
              decoration: InputDecoration(labelText: 'Grade'),
              keyboardType: TextInputType.number,
              validator: (value) =>
              double.tryParse(value!) == null ? 'Enter a valid grade' : null,
              onSaved: (value) => grade = double.parse(value!),
            ),
            DropdownButtonFormField<Gender>(
              value: gender,
              items: Gender.values
                  .map((g) => DropdownMenuItem(
                value: g,
                child: Text(g.toString().split('.').last),
              ))
                  .toList(),
              onChanged: (value) => gender = value!,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).pop(Student(
                    firstName: firstName,
                    lastName: lastName,
                    department: department,
                    grade: grade,
                    gender: gender,
                  ));
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
