import 'package:flutter/material.dart';
import 'package:schoolapp/model/advisortask.dart';


import '../../api.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class AdvisorTaskView extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);
  final int advisorId;
  AdvisorTaskView({required this.advisorId});

  @override
  _AdvisorTaskViewState createState() => _AdvisorTaskViewState(advisorId: advisorId);
}

class _AdvisorTaskViewState extends State<AdvisorTaskView> {
  late Future<List<AdvisorTask>> tasks;
  final int advisorId;
  _AdvisorTaskViewState({required this.advisorId});

  @override
  void initState() {
    super.initState();
    tasks = fetchAdvisorTasks(advisorId);
  }

  Future<List<AdvisorTask>> fetchAdvisorTasks (int advisorId)async {
    final response =
        await http.get(api.getAdvisorTasksUri(advisorId));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final json = jsonDecode(response.body);
        var data = json['data'] as List;
        List<AdvisorTask> tasks = data.map((task) => AdvisorTask.fromJson(task)).toList(); 
        return tasks;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response.body);
        throw Exception('Failed to load advisor\'s tasks');
      }
  }

  @override
  Widget build(BuildContext context) {
   return Center(
        child: FutureBuilder<List<AdvisorTask>> (
          future: tasks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Text> view = snapshot.data!.map((tasks) => Text(tasks.title)).toList();

              return TaskTable(tasks: snapshot.data! );
            } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
  }
}

class TaskTable extends StatelessWidget {
  final List<AdvisorTask> tasks;
  
  TaskTable({required this.tasks});

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

  TableRow createRow(AdvisorTask task) {
    final cellStyle = TextStyle(color: Colors.white, fontSize: 30);

    return TableRow(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        createPaddingText(task.studentId.toString(), cellStyle),
        createPaddingText(task.description, cellStyle),
        createPaddingText(task.deadline, cellStyle)
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
            "Student ID",
            textAlign: alignCenter,
            
            style: cellStyle,
        ), 
        Text("Description", textAlign: alignCenter, style: cellStyle),
        Text("Deadline", textAlign: alignCenter, style: cellStyle),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows =  tasks.map((task) => createRow(task)).toList();
    rows.insert(0, createHeader());
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      defaultColumnWidth: FlexColumnWidth(),
      
      children: rows,
    );
  }
}