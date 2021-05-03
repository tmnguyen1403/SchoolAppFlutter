import 'package:flutter/material.dart';

import '../../api.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../../model/studentcenteractivity.dart';

class StudentCenterActivityView extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);
  final int studentCenterId;
  StudentCenterActivityView({required this.studentCenterId});

  @override
  _StudentCenterActivityViewState createState() => _StudentCenterActivityViewState(studentCenterId: studentCenterId);
}

class _StudentCenterActivityViewState extends State<StudentCenterActivityView> {
  late Future<List<StudentCenterActivity>> activities;
  final int studentCenterId;
  _StudentCenterActivityViewState({required this.studentCenterId});

  @override
  void initState() {
    super.initState();
    activities = fetchStudentCenterActivity(studentCenterId);
  }

  Future<List<StudentCenterActivity>> fetchStudentCenterActivity (int studentCenterId)async {
    final response =
        await http.get(api.getStudentCenterActivitiesUri(studentCenterId));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final json = jsonDecode(response.body);
        var data = json['data'] as List;
        List<StudentCenterActivity> centeractivities = data.map((activity) => StudentCenterActivity.fromJson(activity)).toList(); 
        return centeractivities;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response.body);
        throw Exception('Failed to load advisor\'s activities');
      }
  }

  @override
  Widget build(BuildContext context) {
   return Center(
        child: FutureBuilder<List<StudentCenterActivity>> (
          future: activities,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Text> view = snapshot.data!.map((activities) => Text(activities.title)).toList();

              return ActivityTable(activities: snapshot.data! );
            } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
  }
}

class ActivityTable extends StatelessWidget {
  final List<StudentCenterActivity> activities;
  
  ActivityTable({required this.activities});

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

  TableRow createRow(StudentCenterActivity activity) {
    final cellStyle = TextStyle(color: Colors.white, fontSize: 30);

    return TableRow(
       children: [
        createPaddingText(activity.activityname, cellStyle),
        createPaddingText(activity.type, cellStyle),
        createPaddingText(activity.location, cellStyle),
        createPaddingText(activity.time, cellStyle)
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
            "Activity Name",
            textAlign: alignCenter,
            
            style: cellStyle,
        ), 
        Text("Type", textAlign: alignCenter, style: cellStyle),
        Text("Location", textAlign: alignCenter, style: cellStyle),
        Text("Time", textAlign: alignCenter, style: cellStyle),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows =  activities.map((task) => createRow(task)).toList();
    rows.insert(0, createHeader());
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      defaultColumnWidth: FlexColumnWidth(),
      
      children: rows,
    );
  }
}