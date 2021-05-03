const String HOST = "localhost:3003";

const String STUDENT = "/student";
const String STUDENT_COURSE = STUDENT + "/:id/courses";
const String STUDENT_FINANCE = STUDENT + "/:id/finance";

const String INSTRUCTOR = "/instructor";
const String INSTRUCTOR_COURSE = INSTRUCTOR + "/:id/courses";

const String ADVISOR = "/advisor";
const String ADVISOR_APPOINTMENT = ADVISOR + "/:id/appointments";

dynamic getAllStudentsUri() {
  return Uri.http(HOST, STUDENT);
}

dynamic getAllInstructorUri() {
  return Uri.http(HOST, INSTRUCTOR);
}

dynamic getAllAdvisorUri() {
  return Uri.http(HOST, ADVISOR);
}

dynamic getStudentCourseUri(int id) {
  String path = STUDENT_COURSE.replaceFirst(RegExp(":id"), id.toString());
  print(path);
  return Uri.http(HOST, path);
}

dynamic getStudentFinanceUri(int id) {
  String path = STUDENT_FINANCE.replaceFirst(RegExp(":id"), id.toString());
  print(path);
  return Uri.http(HOST, path);
}

dynamic getInstructorCoursesUri(int id) {
  String path = INSTRUCTOR_COURSE.replaceFirst(RegExp(":id"), id.toString());
  print(path);
  return Uri.http(HOST, path);
}

dynamic getAdvisorAppoinmentsUri(int id) {
  String path = ADVISOR_APPOINTMENT.replaceFirst(RegExp(":id"), id.toString());
  print(path);
  return Uri.http(HOST, path);
}

