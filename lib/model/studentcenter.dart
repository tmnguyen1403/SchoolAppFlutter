class StudentCenter {
  final int id;
  final String name;
  final String location;

  StudentCenter({
    required this.id, 
    required this.name,
    required this.location,
  });

  factory StudentCenter.fromJson(Map<String, dynamic> data) {
    return StudentCenter(
      id: data['ID'], 
      name: data['name'],
      location: data['location'],
    );
  }
}