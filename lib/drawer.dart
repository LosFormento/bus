import 'package:flutter/material.dart';
class esolDrawer extends StatefulWidget {
  @override
  _esolDrawer createState() => _esolDrawer();

}

class _esolDrawer extends State<esolDrawer> {
  bool $isLogged=false;
  void setLogIn() {
    setState(() {
      $isLogged = true;
    });
  }
  void setLogOut() {
    setState(() {
      $isLogged = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if($isLogged){
      print('loged');
    }
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: FlatButton(onPressed: (){
              Navigator.pushNamed(context, '/login');

            },
                child: Text('Войти')),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Расписание'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Памагити, я Олень'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Сообщить об ошибке'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Новости партнеров'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
