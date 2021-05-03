
import 'package:flutter/material.dart';
import '../../model/studentcenter.dart';
import '../rowinfo.dart';

class StudentCenterInfo extends StatelessWidget {
  final StudentCenter studentCenter;
  StudentCenterInfo({required this.studentCenter});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        RowInfo(label: "ID", content: studentCenter.id.toString(),),
        RowInfo(label: "Name", content: studentCenter.name),
        RowInfo(label: "Location", content: studentCenter.location,),
      ]);
  }
}