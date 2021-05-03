
import 'package:flutter/material.dart';
import '../../model/advisor.dart';
import '../rowinfo.dart';

class AdvisorInfo extends StatelessWidget {
  final Advisor advisor;
  AdvisorInfo({required this.advisor});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        RowInfo(label: "ID", content: advisor.id.toString(),),
        RowInfo(label: "Email", content: advisor.email),
        RowInfo(label: "First Name", content: advisor.firstName,),
        RowInfo(label: "Last Name", content: advisor.lastName,),
        RowInfo(label: "Department", content: advisor.department),
        RowInfo(label: "Email", content: advisor.email),
      ]);
  }
}