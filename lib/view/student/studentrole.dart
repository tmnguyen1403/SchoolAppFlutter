import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schoolapp/view/student/studentview.dart';

import '../../Model/student.dart';
import 'package:http/http.dart' as http;
import '../../api.dart' as api;


class StudentRole extends StatefulWidget {
  

  @override
  _StudentRoleState createState() => _StudentRoleState();
}

class _StudentRoleState extends State<StudentRole> {
  late Future<List<Student>> students;

  Future<List<Student>> fetchStudent() async {
    final response =
        await http.get(api.getAllStudentsUri());
        //await http.get(Uri.https('localhost.com:3303', '/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final json = jsonDecode(response.body);
      var data = json['data'] as List;
      List<Student> students = data.map((student) => Student.fromJson(student)).toList(); 
      return students;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load student');
    }
  }

  @override
  void initState() {
    super.initState();
    students = fetchStudent();
  }

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<List<Student>> (
          future: students,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<StudentView> view = snapshot.data!.map((student) => StudentView(student: student)).toList();

              return Column(children: view,);
            } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}