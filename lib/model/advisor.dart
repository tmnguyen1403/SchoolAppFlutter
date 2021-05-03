class Advisor {
  final int id;
  final String firstName;
  final String lastName;
  final String department;
  final String email;

  Advisor({required this.id, 
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.email,
    });

  factory Advisor.fromJson(Map<String, dynamic> data) {
    return Advisor(
      id: data['ID'], 
      firstName: data['firstName'],
      lastName: data['lastName'],
      department: data['department'],
      email: data['email'],
    );
  }
}