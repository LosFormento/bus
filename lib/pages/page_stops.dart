import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StopPage extends StatefulWidget {
  @override
  StopPageState createState() => new StopPageState();
}

class StopPageState extends State<StopPage> {
  var data;
  List directions;
  List directionsForDisplay;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://bus.esoligorsk.by/json/poi.json"),
        headers: {"Accept": "application/json; charset=utf-8"});
    this.setState(() {
      data = jsonDecode(response.body);
    });
    //print(data['ost_list']);
    directions = data;
    directionsForDisplay = directions;

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text("Остановки")),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (text) {
                  text = text.toLowerCase();
                  setState(() {
                    directionsForDisplay = directions.where((note) {
                      var noteTitle = note["name"].toLowerCase();
                      var noteDesc=note["alias"].toLowerCase();
                      return noteTitle.contains(text) ||  noteDesc.contains(text);
                    }).toList();
                  });
                },
                //controller: editingController,
                decoration: InputDecoration(
                    labelText: "Поиск",
                    hintText: "2 или Вокзал или КДП",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: directionsForDisplay == null ? 0 : directionsForDisplay.length,
                itemBuilder: (BuildContext context, int index) {
                  return _direction(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _direction(index){
   return Card(

      child: FlatButton(
        onPressed: (){
          Navigator.pushNamed(context, '/stop_detail',
            arguments: <String, String>{
              'name': directionsForDisplay[index]["name"],
              'title':directionsForDisplay[index]["comment"],
              'id': directionsForDisplay[index]["id"].toString(),
            },);
        },

        child: Container(

          height: 50,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(right: 15),
                  //width: 30,
                  child: Text(directionsForDisplay[index]["name"],style: TextStyle(fontSize: 18),),
                ),
                Container(
                  child: Flexible(
                    child: Text(directionsForDisplay[index]["comment"]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );



  }

}
