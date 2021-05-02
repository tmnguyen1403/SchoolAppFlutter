import 'package:flutter/material.dart';

//TabViews

import 'instructorinfo.dart';
import 'instructorcoursehistory.dart';

//Model
import '../../model/instructor.dart';


class InstructorView extends StatelessWidget {
  final Instructor instructor;
  InstructorView({required this.instructor});

  @override
  Widget build(BuildContext context) {
    return
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Spacer(flex:4),
         Expanded(
           flex: 2,
           child: 
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade300,
            
          ),
          onPressed: () => {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => InstructorNavigation(instructor: instructor,), 
              ) 
            ) 
          }, 
          child: Text(instructor.email)
        )),
        Spacer(flex: 4),
    ],);
  }
}


class InstructorNavigation extends StatefulWidget {
  
  final Instructor instructor;
  InstructorNavigation({required this.instructor});

  @override
  _InstructorNavigationState createState() => _InstructorNavigationState(instructor);
}

class _InstructorNavigationState extends State<InstructorNavigation> {
  late Instructor instructor;
  int _selectedIndex = 0;
  late List <Widget> items;
  _InstructorNavigationState(Instructor instructor) {
    this.instructor = instructor;
    items = <Widget> [
      InstructorInfo(instructor: instructor,),
      InstructorCourseHistory(instructorId: instructor.id,),
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
      appBar: AppBar(title: Text("Instructor"),),
      body: items[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quick_contacts_mail_outlined),
            label: 'Instructor Info'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course History'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        ),
    );
  }
}