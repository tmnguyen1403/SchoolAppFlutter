import 'package:flutter/material.dart';
import 'package:schoolapp/model/advisorappointment.dart';


import '../../api.dart' as api;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class AdvisorAppoinmentView extends StatefulWidget {
  //MyApp({required Key key}) : super(key: key);
  final int advisorId;
  AdvisorAppoinmentView({required this.advisorId});

  @override
  _AdvisorAppoinmentViewState createState() => _AdvisorAppoinmentViewState(advisorId: advisorId);
}

class _AdvisorAppoinmentViewState extends State<AdvisorAppoinmentView> {
  late Future<List<AdvisorAppointment>> appointments;
  final int advisorId;
  _AdvisorAppoinmentViewState({required this.advisorId});

  @override
  void initState() {
    super.initState();
    appointments = fetchAdvisorAppointments(advisorId);
  }

  Future<List<AdvisorAppointment>> fetchAdvisorAppointments (int instructorId)async {
    final response =
        await http.get(api.getAdvisorAppoinmentsUri(instructorId));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final json = jsonDecode(response.body);
        var data = json['data'] as List;
        List<AdvisorAppointment> appointments = data.map((appointment) => AdvisorAppointment.fromJson(appointment)).toList(); 
        return appointments;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response.body);
        throw Exception('Failed to load advisor\'s appointments');
      }
  }

  @override
  Widget build(BuildContext context) {
   return Center(
        child: FutureBuilder<List<AdvisorAppointment>> (
          future: appointments,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Text> view = snapshot.data!.map((appointment) => Text(appointment.title)).toList();

              return AppointmentTable(appointments: snapshot.data! );
            } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      );
  }
}

class AppointmentTable extends StatelessWidget {
  final List<AdvisorAppointment> appointments;
  
  AppointmentTable({required this.appointments});

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
  TableRow createRow(AdvisorAppointment appointment) {
    final cellStyle = TextStyle(color: Colors.white, fontSize: 30);

    return TableRow(
       //mainAxisAlignment: MainAxisAlignment.center,
       children: [
        createPaddingText(appointment.studentId.toString(), cellStyle),
        createPaddingText(appointment.date, cellStyle),
        createPaddingText(appointment.note, cellStyle)
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
        Text("Date", textAlign: alignCenter, style: cellStyle),
        Text("Note", textAlign: alignCenter, style: cellStyle),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows =  appointments.map((appointment) => createRow(appointment)).toList();
    rows.insert(0, createHeader());
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      defaultColumnWidth: FlexColumnWidth(),
      
      children: rows,
    );
  }
}