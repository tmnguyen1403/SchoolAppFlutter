class AdvisorAppointment {
  final int studentId;
  final String note;
  final String date;

  AdvisorAppointment({required this.studentId, 
    required this.note,
    required this.date,
    });

  factory AdvisorAppointment.fromJson(Map<String, dynamic> data) {
    return AdvisorAppointment(
      studentId: data['studentId'], 
      note: data['note'],
      date: data['date'],
    );
  }
}