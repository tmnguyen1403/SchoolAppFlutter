import 'package:flutter/material.dart';
import 'package:schoolapp/view/advisor/advisortaskview.dart';

//TabViews

import 'advisorinfo.dart';
import 'advisorappointmentview.dart';
import 'advisortaskview.dart';

//Model
import '../../model/advisor.dart';


class AdvisorView extends StatelessWidget {
  final Advisor advisor;
  AdvisorView({required this.advisor});

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
                builder: (context) => AdvisorNavigation(advisor: advisor,), 
              ) 
            ) 
          }, 
          child: Text(advisor.email)
        )),
        Spacer(flex: 4),
    ],);
  }
}


class AdvisorNavigation extends StatefulWidget {
  
  final Advisor advisor;
  AdvisorNavigation({required this.advisor});

  @override
  _AdvisorNavigationState createState() => _AdvisorNavigationState(advisor);
}

class _AdvisorNavigationState extends State<AdvisorNavigation> {
  late Advisor advisor;
  int _selectedIndex = 0;
  late List <Widget> items;
  _AdvisorNavigationState(Advisor advisor) {
    this.advisor = advisor;
    items = <Widget> [
      AdvisorInfo(advisor: advisor,),
      AdvisorAppoinmentView(advisorId: advisor.id,),
       AdvisorTaskView(advisorId: advisor.id,),
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
      appBar: AppBar(title: Text("Advisor"),),
      body: items[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quick_contacts_mail_outlined),
            label: 'Advisor Info'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        ),
    );
  }
}