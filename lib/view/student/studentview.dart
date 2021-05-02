import 'dart:html';

import 'package:flutter/material.dart';
import '../../Model/student.dart';
import '../rowinfo.dart';
import 'studentenrollment.dart';

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
              builder: (context) => StudentNavigation(student: student,), 
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



class StudentNavigation extends StatefulWidget {
  
  final Student student;
  StudentNavigation({required this.student});

  @override
  _StudentNavigationState createState() => _StudentNavigationState(student);
}

class _StudentNavigationState extends State<StudentNavigation> {
  late Student student;
  int _selectedIndex = 0;
  late List <Widget> items;
  _StudentNavigationState(Student student) {
    this.student = student;
    items = <Widget> [
      StudentInfo(student: student,),
      StudentEnrollment(studentId: student.id,),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student"),),
      body: items[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Student Info'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course Enrolled'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        ),
    );
  }
}