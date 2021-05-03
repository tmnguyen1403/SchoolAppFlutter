import 'package:flutter/material.dart';

import '../../model/finance.dart';
import '../../api.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class StudentFinance extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);
  final int studentId;
  StudentFinance({required this.studentId});

  @override
  _StudentFinanceState createState() => _StudentFinanceState(studentId: studentId);
}

class _StudentFinanceState extends State<StudentFinance> {
  late Future<List<Finance>> finances;
  final int studentId;
  _StudentFinanceState({required this.studentId});

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
    //futureStudent = fetchStudent();
    finances = fetchStudentFinance(studentId);
  }

  Future<List<Finance>> fetchStudentFinance (int studentId)async {
    final response =
        await http.get(api.getStudentFinanceUri(studentId));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final json = jsonDecode(response.body);
        var data = json['data'] as List;
        List<Finance> courses = data.map((course) => Finance.fromJson(course)).toList(); 
        return courses;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response.body);
        throw Exception('Failed to load student\' courses');
      }
  }

  @override
  Widget build(BuildContext context) {
   return Center(
        child: FutureBuilder<List<Finance>> (
          future: finances,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Text> view = snapshot.data!.map((course) => Text(course.title)).toList();

              return CourseTable(courses: snapshot.data! );
            } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
  }
}

class CourseTable extends StatelessWidget {
  final List<Finance> courses;
  
  CourseTable({required this.courses});

  Padding createPaddingText(String content, TextStyle cellStyle) {
    final alignCenter = TextAlign.center;
    return  Padding(padding: const EdgeInsets.all(8.0),child: 
              Text(
              content,
              textAlign: alignCenter,
              
              style: cellStyle,
        ),
    );
  }
  TableRow createRow(Finance course) {
    final cellStyle = TextStyle(color: Colors.white, fontSize: 30);

    return TableRow(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        createPaddingText(course.id.toString(), cellStyle),
        createPaddingText(course.eligibility, cellStyle),
        createPaddingText(course.balance.toString(), cellStyle),
        ],
      );
  }

  TableRow createHeader() {
    final cellStyle = TextStyle(
              color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 40);
    final alignCenter = TextAlign.center;
    return TableRow(
       
       children: [
        Text(
            "ID",
            textAlign: alignCenter,
            
            style: cellStyle,
        ), 
        Text("Eligibility", textAlign: alignCenter, style: cellStyle),
        Text("Balance", textAlign: alignCenter, style: cellStyle),       
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows =  courses.map((course) => createRow(course)).toList();
    rows.insert(0, createHeader());
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      defaultColumnWidth: FlexColumnWidth(),
      
      children: rows,
    );
  }
}