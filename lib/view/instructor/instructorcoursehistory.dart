import 'package:flutter/material.dart';
import 'package:schoolapp/model/instructorcourse.dart';


import '../../api.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class InstructorCourseHistory extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);
  final int instructorId;
  InstructorCourseHistory({required this.instructorId});

  @override
  _InstructorCourseHistoryState createState() => _InstructorCourseHistoryState(instructorId: instructorId);
}

class _InstructorCourseHistoryState extends State<InstructorCourseHistory> {
  late Future<List<InstructorCourse>> courses;
  final int instructorId;
  _InstructorCourseHistoryState({required this.instructorId});

  @override
  void initState() {
    super.initState();
    courses = fetchInstructorCourses(instructorId);
  }

  Future<List<InstructorCourse>> fetchInstructorCourses (int instructorId)async {
    final response =
        await http.get(api.getInstructorCoursesUri(instructorId));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final json = jsonDecode(response.body);
        var data = json['data'] as List;
        List<InstructorCourse> courses = data.map((course) => InstructorCourse.fromJson(course)).toList(); 
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
        child: FutureBuilder<List<InstructorCourse>> (
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
  final List<InstructorCourse> courses;
  
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
  TableRow createRow(InstructorCourse course) {
    final cellStyle = TextStyle(color: Colors.white, fontSize: 30);

    return TableRow(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        createPaddingText(course.id.toString(), cellStyle),
        createPaddingText(course.title, cellStyle),
        createPaddingText(course.semester, cellStyle)
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
            "Course ID",
            textAlign: alignCenter,
            
            style: cellStyle,
        ), 
        Text("Title", textAlign: alignCenter, style: cellStyle),
        Text("Semester", textAlign: alignCenter, style: cellStyle),
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