import 'dart:html';

import 'package:flutter/material.dart';
import 'Model/student.dart';

class StudentView extends StatelessWidget {
  final Student student;
  StudentView({required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ElevatedButton(
        onPressed: () => {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => StudentInfo(student: student,), 
            ) 
          ) 
        }, 
        child: Text(student.email)
      )
    ],);
  }
}

class StudentInfo extends StatelessWidget {
  final Student student;
  StudentInfo({required this.student});
  @override
  Widget build(BuildContext context) {
    final String dob = student.dob.substring(0, 10);
    return Scaffold(
      appBar: AppBar(title: Text("Student Info"),),
      body: Column(children: <Widget>[
        RowInfo(label: "ID", content: student.id.toString(),),
        RowInfo(label: "email", content: student.email),
        RowInfo(label: "firstName", content: student.firstName,),
        RowInfo(label: "lastName", content: student.lastName,),
        RowInfo(label: "sex", content: student.sex),
        RowInfo(label: "dob", content: dob),
      ],),
    );
      
  }
}

class RowInfo extends StatelessWidget {
  final String label;
  final String content;

  RowInfo({required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
     return Row(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            textAlign: TextAlign.center,
            
            style: TextStyle(
              color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 30),
        )), 
        
        Expanded(
          child:Text(content, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        ],
      );
  }
}

// Container(
//         margin: const EdgeInsets.all(5.0),
//         padding: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(border: Border.all()),
//         child: Text("id", style: TextStyle(
//         color: Colors.blue[700], fontWeight: FontWeight.bold),
//         )
//       ) 