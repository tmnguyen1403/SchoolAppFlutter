import 'package:flutter/material.dart';

import '../../Model/studentcourse.dart';
import '../../api.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
//import 'rowinfo.dart';

// class StudentEnrollment extends StatefulWidget {
//   @override
//   _StudentEnrollmentState createState() => _StudentEnrollmentState();
// }

// class _StudentEnrollmentState extends State<StudentEnrollment> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget buid(BuildContext contex) {
//     return Text("hello");
//   }
// }

class StudentEnrollment extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);
  final int studentId;
  StudentEnrollment({required this.studentId});
  
  @override
  _StudentEnrollmentState createState() => _StudentEnrollmentState(studentId: studentId);
}

class _StudentEnrollmentState extends State<StudentEnrollment> {
  late Future<List<StudentCourse>> courses;
  final int studentId;
  _StudentEnrollmentState({required this.studentId});

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
    //futureStudent = fetchStudent();
    courses = fetchStudentCourse(studentId);
  }

  Future<List<StudentCourse>> fetchStudentCourse (int studentId)async {
    final response =
        await http.get(api.getStudentCourseUri(studentId));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final json = jsonDecode(response.body);
        var data = json['data'] as List;
        List<StudentCourse> courses = data.map((course) => StudentCourse.fromJson(course)).toList(); 
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
        child: FutureBuilder<List<StudentCourse>> (
          future: courses,
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
  final List<StudentCourse> courses;
  
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
  TableRow createRow(StudentCourse course) {
    final cellStyle = TextStyle(color: Colors.white, fontSize: 30);

    return TableRow(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        createPaddingText(course.id.toString(), cellStyle),
        createPaddingText(course.title, cellStyle),
        createPaddingText(course.credits.toString(), cellStyle),
        createPaddingText(course.status, cellStyle)
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
        Text("Title", textAlign: alignCenter, style: cellStyle),
        Text("Credits", textAlign: alignCenter, style: cellStyle),
        Text("Status", textAlign: alignCenter, style: cellStyle),
        
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
      // columnWidths: {
      //   0: FixedColumnWidth(50),
      //   1: FlexColumnWidth(1),
      //   2: FlexColumnWidth(1),
      //   3: FlexColumnWidth(1),
      // },
      children: rows,
    );
  }
}