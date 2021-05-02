import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';


import '../../model/instructor.dart';
import 'instructorview.dart';

import 'package:http/http.dart' as http;
import '../../api.dart' as api;


class InstructorRole extends StatefulWidget {
  

  @override
  _InstructorRoleState createState() => _InstructorRoleState();
}

class _InstructorRoleState extends State<InstructorRole> {
  late Future<List<Instructor>> instructors;

  Future<List<Instructor>> fetchInstructor() async {
    final response =
        await http.get(api.getAllInstructorUri());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final json = jsonDecode(response.body);
      var data = json['data'] as List;
      List<Instructor> instructors = data.map((student) => Instructor.fromJson(student)).toList(); 
      return instructors;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load instructors');
    }
  }

  @override
  void initState() {
    super.initState();
    instructors = fetchInstructor();
  }

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instructor Login"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<Instructor>> (
          future: instructors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic data = snapshot.data!;

              return Container(
                alignment: Alignment.center,
                child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return InstructorView(instructor: data[index],);
                }, 
                separatorBuilder: (BuildContext context, int index) => const Divider(), 
                itemCount: data.length
              ));
              // return ListView(
              //   padding: const EdgeInsets.all(8),
              //   children: views,);
             
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