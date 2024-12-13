enum Department { finance, law, it, medical }
enum Gender { male, female }

class Student {
  final String firstName;
  final String lastName;
  final Department department;
  final double grade;
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

const Map<Department, String> departmentIcons = {
  Department.finance: '💵',
  Department.law: '⚖️',
  Department.it: '💻',
  Department.medical: '🩺',
};
