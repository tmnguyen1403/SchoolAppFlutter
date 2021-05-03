class AdvisorTask {
  final int studentId;
  final String description;
  final String deadline;

  AdvisorTask({required this.studentId, 
    required this.description,
    required this.deadline,
    });

  factory AdvisorTask.fromJson(Map<String, dynamic> data) {
    return AdvisorTask(
      studentId: data['studentId'], 
      description: data['description'],
      deadline: data['deadline'],
    );
  }
}