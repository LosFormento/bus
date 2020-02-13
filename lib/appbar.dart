
import 'package:flutter/material.dart';
class EsolAppBar extends StatefulWidget {
  @override
  _EsolAppBarState createState() => _EsolAppBarState();
}

class _EsolAppBarState extends State<EsolAppBar> {
  bool $hasMessage=false;
  void setHasMessage() {
    setState(() {
      $hasMessage = true;
    });
  }
  void setNoMessage() {
    setState(() {
      $hasMessage = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if($hasMessage){
      print('loged');
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text("Тут красивый логотип"),
            height: 50,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.notifications_none),
                      onPressed: () =>{
                        Navigator.pushNamed(context, '/messages')
                      },
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
