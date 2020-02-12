import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionDetailPage extends StatefulWidget {
  @override
  DirectionDetailPageState createState() => new DirectionDetailPageState();
}

class DirectionDetailPageState extends State<DirectionDetailPage> {
  Map data,first_stop_data;
  List stops;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://bus.esoligorsk.by/json/direction_app_json.php?dbid=42"),
        headers: {"Accept": "application/json; charset=utf-8"});

    var first_stop_response=await http.get(
        Uri.encodeFull("http://bus.esoligorsk.by/json/timetables2_app_json.php?id=267&dir_id=42"),
        headers: {"Accept": "application/json; charset=utf-8"});

    this.setState(() {
      data = jsonDecode(response.body);
      first_stop_data=jsonDecode(first_stop_response.body);
      stops = data['ost_list'];
    });

    return "Success!";
  }

  @override
  void initState() {
     this.getData();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(title: new Text("Один маршут 42")),
      body: Column(
        children: <Widget>[
          Text("asdasdas"),
        ],
      ),
    );
  }
}
