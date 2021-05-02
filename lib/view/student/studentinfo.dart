
import 'package:flutter/material.dart';
import '../../model/student.dart';
import '../rowinfo.dart';

class StudentInfo extends StatelessWidget {
  final Student student;
  StudentInfo({required this.student});
  @override
  Widget build(BuildContext context) {
    final String dob = student.dob.substring(0, 10);
    return Column(children: <Widget>[
        RowInfo(label: "ID", content: student.id.toString(),),
        RowInfo(label: "email", content: student.email),
        RowInfo(label: "firstName", content: student.firstName,),
        RowInfo(label: "lastName", content: student.lastName,),
        RowInfo(label: "sex", content: student.sex),
        RowInfo(label: "dob", content: dob),
      ]);
  }
}