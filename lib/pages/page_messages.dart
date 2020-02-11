import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() => new MessagePageState();
}

class MessagePageState extends State<MessagePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://174.by/json_test/messages.json"),
        headers: {
          "Accept": "application/json; charset=utf-8"
        }
    );

    this.setState(() {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    });

   //print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Уведомления")),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(data[index]["title"]),
            ),
          );
        },
      ),
    );
  }
}