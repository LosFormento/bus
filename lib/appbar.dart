import 'package:esol_bus_2/drawer.dart';
import 'package:flutter/material.dart';
class esolAppBar extends StatefulWidget {
  @override
  _esolAppBarState createState() => _esolAppBarState();

}

class _esolAppBarState extends State<esolAppBar> {
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
                      onPressed: () =>{},
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
