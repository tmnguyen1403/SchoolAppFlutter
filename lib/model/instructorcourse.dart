class InstructorCourse {
  final int id;
  final String title;
  final String semester;

  InstructorCourse({ 
    required this.id,
    required this.title,
    required this.semester}
  );

  factory InstructorCourse.fromJson(Map<String, dynamic> data) {
    return InstructorCourse(
      id: data['id'], 
      title: data['title'],
      semester: data['semester']
    );
  }
}