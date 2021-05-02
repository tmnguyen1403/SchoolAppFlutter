class Instructor {
  final int id;
  final String firstName;
  final String lastName;
  final String department;
  final String title;
  final String email;
  final double salary;

  Instructor({required this.id, 
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.title,
    required this.email,
    required this.salary,});

  factory Instructor.fromJson(Map<String, dynamic> data) {
    return Instructor(
      id: data['ID'], 
      firstName: data['firstName'],
      lastName: data['lastName'],
      department: data['department'],
      title: data['title'],
      email: data['email'],
      salary: data['salary'],
    );
  }
}