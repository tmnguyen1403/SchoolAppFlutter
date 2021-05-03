import 'dart:async';

import 'package:flutter/material.dart';
import 'package:schoolapp/view/rowspacing.dart';

import 'view/student/studentrole.dart';
import 'view/instructor/instructorrole.dart';
import 'view/advisor/advisorrole.dart';

//Client - send request to server 
//Server - receive and process the request


void main() => runApp(UI());

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/admin': (context) => Admin(),
        '/student': (context) => StudentRole(),
        '/instructor': (context) => InstructorRole(),
        '/advisor': (context) => AdvisorRole(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School DBMS'),
        centerTitle: true,
      ),
      body: Role(),
    );
  }
}

class Role extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
      Divider(),           
      Admin(),
      Divider(),
      Dean(),
      Divider(),
      AdvisorButton(),
      Divider(),
      InstructorButton(),
      Divider(),
      StudentButton(),
      Spacer(flex: 2),
    ],));
  }
}

class AdvisorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton contentButton = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/advisor');
        print("I pressed instructor");
      }, 
      child: Text('Advisor'),
    );
    return RowSpacing(contentWidget: contentButton);
  }
}

class InstructorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton contentButton = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/instructor');
        print("I pressed instructor");
      }, 
      child: Text('Instructor'),
    );
    return RowSpacing(contentWidget: contentButton);
  }
}

class StudentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton contentButton = ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/student');
          print("I pressed student");
        }, 
        child: Text('Student'),
        );
    return RowSpacing(contentWidget: contentButton);
  }
}
//Admin
class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton contentButton = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/admin');
        print("I pressed you");
      }, 
      child: Text('Admin'),
    );
    return RowSpacing(contentWidget: contentButton);
  }
}

//Dead
class Dean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ElevatedButton contentButton =  ElevatedButton(
      onPressed: () {print("I pressed you");}, 
      child: Text('Dean'),
    );
     return RowSpacing(contentWidget: contentButton);
  }
}