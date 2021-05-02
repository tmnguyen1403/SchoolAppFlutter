class StudentCourse {
  final int id;
  final String title;
  final int credits;
  final String status;

  StudentCourse({ 
    required this.id,
    required this.title,
    required this.credits,
    required this.status,});

  factory StudentCourse.fromJson(Map<String, dynamic> data) {
    return StudentCourse(
      id: data['id'], 
      title: data['title'],
      credits: data['credits'],
      status: data['status'],
    );
  }
}