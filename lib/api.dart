const String HOST = "localhost:3003";

const String STUDENT = "/student";
const String STUDENT_COURSE = "/student/:id/courses";
const String STUDENT_FINANCE = "/student/:id/finance";

dynamic getAllStudentsUri() {
  return Uri.http(HOST, STUDENT);
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
