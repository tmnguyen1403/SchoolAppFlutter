import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';


import '../../model/advisor.dart';
import 'advisorview.dart';

import 'package:http/http.dart' as http;
import '../../api.dart' as api;


class AdvisorRole extends StatefulWidget {
  

  @override
  _AdvisorRoleState createState() => _AdvisorRoleState();
}

class _AdvisorRoleState extends State<AdvisorRole> {
  late Future<List<Advisor>> advisors;

  Future<List<Advisor>> fetchAdvisor() async {
    final response =
        await http.get(api.getAllAdvisorUri());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final json = jsonDecode(response.body);
      var data = json['data'] as List;
      List<Advisor> advisors = data.map((advisor) => Advisor.fromJson(advisor)).toList(); 
      return advisors;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load Advisors');
    }
  }

  @override
  void initState() {
    super.initState();
    advisors = fetchAdvisor();
  }

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advisor Login"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<Advisor>> (
          future: advisors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic data = snapshot.data!;

              return Container(
                alignment: Alignment.center,
                child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return AdvisorView(advisor: data[index],);
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