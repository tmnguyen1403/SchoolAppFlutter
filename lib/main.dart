import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Student> fetchStudent() async {
  final response =
      await http.get(Uri.http('localhost:3003', ''));
      //await http.get(Uri.https('localhost.com:3303', '/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Student.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load student');
  }
}

class Student {
  final int id;
  final String firstName;

  Student({required this.id, required this.firstName});

  factory Student.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Student(
      id: data['ID'], 
      firstName: data['firstName'],
    );
  }
}

void main() => runApp(MyApp());

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
    futureStudent = fetchStudent();
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
