
import 'package:flutter/material.dart';
import '../../model/instructor.dart';
import '../rowinfo.dart';

class InstructorInfo extends StatelessWidget {
  final Instructor instructor;
  InstructorInfo({required this.instructor});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        RowInfo(label: "ID", content: instructor.id.toString(),),
        RowInfo(label: "Email", content: instructor.email),
        RowInfo(label: "First Name", content: instructor.firstName,),
        RowInfo(label: "Last Name", content: instructor.lastName,),
        RowInfo(label: "Department", content: instructor.department),
        RowInfo(label: "Title", content: instructor.title),
        RowInfo(label: "Salary", content: instructor.salary.toString()),
      ]);
  }
}