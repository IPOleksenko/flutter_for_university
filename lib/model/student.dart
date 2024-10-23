enum Department { finance, law, it, medical }
enum Gender { male, female }

// A class that stores information about a student
class Student {
  final String firstName;
  final String lastName;
  final Department department;
  final int grade;
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

// Icons associated with each department
final Map<Department, String> departmentIcons = {
  Department.finance: '💵',
  Department.law: '⚖️',
  Department.it: '💻',
  Department.medical: '🩺',
};
