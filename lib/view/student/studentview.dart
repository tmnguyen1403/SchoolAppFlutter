import 'package:flutter/material.dart';
import 'package:schoolapp/view/student/studentfinance.dart';

//TabViews
import 'studentenrollment.dart';
import 'studentfinance.dart';
import 'studentinfo.dart';

import '../rowspacing.dart';

//Model
import '../../model/student.dart';


class StudentView extends StatelessWidget {
  final Student student;
  StudentView({required this.student});

  @override
  Widget build(BuildContext context) {
    final ElevatedButton buttonContent =  ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade300,
            
          ),
          onPressed: () => {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => StudentNavigation(student: student,), 
              ) 
            ) 
          }, 
          child: Text(student.email)
        );
    return RowSpacing(contentWidget: buttonContent);
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
      StudentFinance(studentId: student.id,)
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
            icon: Icon(Icons.quick_contacts_mail_outlined),
            label: 'Student Info'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course Enrolled'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Finance'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        ),
    );
  }
}