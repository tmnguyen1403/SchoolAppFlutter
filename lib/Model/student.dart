class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String sex;
  final String dob;
  final String email;
  final int centerID;
  final int advisorID;

  Student({required this.id, 
    required this.firstName,
    required this.lastName,
    required this.sex,
    required this.dob,
    required this.email,
    required this.centerID,
    required this.advisorID,});

  factory Student.fromJson(Map<String, dynamic> data) {
    return Student(
      id: data['ID'], 
      firstName: data['firstName'],
      lastName: data['lastName'],
      sex: data['sex'],
      dob: data['dateOfBirth'],
      email: data['email'],
      centerID: data['centerID'],
      advisorID: data['advisorID'],
    );
  }
}