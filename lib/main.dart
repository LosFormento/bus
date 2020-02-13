import 'package:esol_bus_2/pages/page_directions.dart';
import 'package:esol_bus_2/pages/page_login.dart';
import 'package:flutter/material.dart';
import 'package:esol_bus_2/appbar.dart';
import 'package:esol_bus_2/drawer.dart';
import 'package:esol_bus_2/pages/page_messages.dart';
import 'package:esol_bus_2/pages/page_direction_detail.dart';
import 'pages/page_messages.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/login': (context) => LoginScreen(),
        '/messages': (context) => MessagePage(),
        '/directions': (context) => DirectionPage(),
        '/direction_detail': (context) => DirectionDetailPage(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _appbar= new EsolAppBar();
  var _drawer= new esolDrawer();
  var _isLogged=false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child:  _appbar,
          preferredSize: Size.fromHeight(200),
        ),
        body: SafeArea(
          child: Container(

            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                          _mainPageButton("Маршруты",'/directions'),
                          _mainPageButton("Остановки",'/'),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            _mainPageButton("Карта",'/'),
                        _mainPageButton("Проложить",'/'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: _drawer,// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _mainPageButton(String text,String route) {
    return new  Expanded(
      child: Container(
        child: Center(
          child: Container(
              child: FlatButton(
                child: Text(text),
                onPressed: () =>{
                Navigator.pushNamed(context, route)
              },
            ),
          ),
        ),
      ),
    );
  }

  void setUser(bool isLogged){
    setState(() {
      _isLogged=isLogged;
    });
  }


}
