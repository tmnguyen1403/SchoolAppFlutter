import 'package:flutter/material.dart';
import 'Model/student.dart';

class StudentView extends StatelessWidget {
  final Student student;
  StudentView({required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(student.email),
    ],);
  }
}

class StudentInfo extends StatelessWidget {
  final Student student;
  StudentInfo({required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(student.email),
      Text(student.id.toString()),
      Text(student.firstName),
      Text(student.lastName),
      Text(student.sex),
      Text(student.dob),
    ],);
  }
}