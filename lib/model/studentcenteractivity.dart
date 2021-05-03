class StudentCenterActivity {
  final String location;
  final String activityname;
  final String time;
  final String type;

  StudentCenterActivity({
    required this.location,
    required this.activityname,
    required this.type,
    required this.time,
  });

  factory StudentCenterActivity.fromJson(Map<String, dynamic> data) {
    return StudentCenterActivity(
      activityname: data['activityname'],
      type: data['type'],
      location: data['location'],
      time: data['time'],
    );
  }
}