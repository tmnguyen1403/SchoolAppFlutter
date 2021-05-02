import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'studentview.dart';
import 'Model/student.dart';
import 'studentrole.dart';

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
      }
    );
  }
}

class StudentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/student');
        print("I pressed student");
      }, 
      child: Text('Student'),
    );
  }
}



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School System'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Role(),
    );
  }
}

class Role extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Admin(),
      Dean(),
      Instructor(),
      Text("Advisor"),
      StudentButton(),
    ],);
  }
}

//Admin
class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/admin');
        print("I pressed you");
      }, 
      child: Text('Admin'),
    );
  }
}

//Dead
class Dean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {print("I pressed you");}, 
      child: Text('Dean'),
    );
  }
}

//Instructor
class Instructor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {print("I pressed you");}, 
      child: Text('Instructor'),
    );
  }
}
// class Admin extends StatefulWidget {
//   //MyApp({required Key key}) : super(key: key);

//   @override
//   _AdminState createState() => _AdminState();
// }

// class _AdminState extends State<Admin> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Text("Admin"),
//       Text("Dean"),
//       Text("Instructor"),
//       Text("Advisor"),
//       Text("Student"),
//     ],);
//   }
// }
//
class MyApp extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Student> futureStudent;

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
    //futureStudent = fetchStudent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Student>(
            future: futureStudent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.firstName);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class StudentList extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late Future<Student> futureStudent;

  @override
  void initState() {
    super.initState();
    //futureStudent = fetchStudent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Student>(
            future: futureStudent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.firstName);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

// Future.Delayed
// Column <Studetn>