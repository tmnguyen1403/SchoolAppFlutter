import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';


import '../../model/studentcenter.dart';
import 'studentcenterview.dart';

import 'package:http/http.dart' as http;
import '../../api.dart' as api;


class StudentCenterRole extends StatefulWidget {
  @override
  _StudentCenterRoleState createState() => _StudentCenterRoleState();
}

class _StudentCenterRoleState extends State<StudentCenterRole> {
  late Future<List<StudentCenter>> studentcenters;

  Future<List<StudentCenter>> fetchstudentcenter() async {
    final response =
        await http.get(api.getAllStudentCenterUri());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final json = jsonDecode(response.body);
      var data = json['data'] as List;
      List<StudentCenter> centers = data.map((studentcenter) => StudentCenter.fromJson(studentcenter)).toList(); 
      return centers;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load studentcenters');
    }
  }

  @override
  void initState() {
    super.initState();
    studentcenters = fetchstudentcenter();
  }

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("studentcenter Login"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<StudentCenter>> (
          future: studentcenters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic data = snapshot.data!;

              return Container(
                alignment: Alignment.center,
                child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return StudentCenterView(studentCenter: data[index],);
                }, 
                separatorBuilder: (BuildContext context, int index) => const Divider(), 
                itemCount: data.length
              ));
             
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