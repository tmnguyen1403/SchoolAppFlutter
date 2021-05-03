import 'package:flutter/material.dart';

//TabViews

import 'studentcenterinfo.dart';
import 'studentcenteractivityview.dart';

//Model
import '../../model/studentcenter.dart';


class StudentCenterView extends StatelessWidget {
  final StudentCenter studentCenter;
  StudentCenterView({required this.studentCenter});

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
                builder: (context) => StudentCenterNavigation(studentCenter: studentCenter,), 
              ) 
            ) 
          }, 
          child: Text(studentCenter.name)
        )),
        Spacer(flex: 4),
    ],);
  }
}


class StudentCenterNavigation extends StatefulWidget {
  
  final StudentCenter studentCenter;
  StudentCenterNavigation({required this.studentCenter});

  @override
  _StudentCenterNavigationState createState() => _StudentCenterNavigationState(studentCenter);
}

class _StudentCenterNavigationState extends State<StudentCenterNavigation> {
  late StudentCenter studentCenter;
  int _selectedIndex = 0;
  late List <Widget> items;
  _StudentCenterNavigationState(StudentCenter studentCenter) {
    this.studentCenter = studentCenter;
    items = <Widget> [
      StudentCenterInfo(studentCenter: studentCenter,),
      StudentCenterActivityView(studentCenterId: studentCenter.id,),
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
      appBar: AppBar(title: Text("StudentCenter"),),
      body: items[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quick_contacts_mail_outlined),
            label: 'Info'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Activities'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        ),
    );
  }
}