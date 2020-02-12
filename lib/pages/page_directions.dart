import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionPage extends StatefulWidget {
  @override
  DirectionPageState createState() => new DirectionPageState();
}

class DirectionPageState extends State<DirectionPage> {
  var data;
  List directions;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://bus.esoligorsk.by/json/direction_app_json.php"),
        headers: {"Accept": "application/json; charset=utf-8"});
    this.setState(() {
      data = jsonDecode(response.body);
    });
    //print(data['ost_list']);
    directions = data['ost_list'];
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text("Маршруты")),
      body: ListView.builder(
        itemCount: directions == null ? 0 : directions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: FlatButton(
              onPressed: (){
                Navigator.pushNamed(context, '/direction_detail');
              },
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    width: 30,
                    child: Center(child: Text(directions[index]["name"])),
                  ),
                  Container(
                    child: Flexible(
                      child: Text(directions[index]["dir_title"]),
                    ),
                  ),
                  Container(
                    child: Text(directions[index]["dir_id"]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
