import 'package:flutter/material.dart';
import 'package:esol_bus_2/models/direction.dart';
import 'package:esol_bus_2/api/bus.dart';

class DirectionDetailPage extends StatefulWidget {
  @override
  _DirectionDetailPageState createState() => _DirectionDetailPageState();
}

class _DirectionDetailPageState extends State<DirectionDetailPage> {

  int dirId=42;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Инфо',
              ),
              Tab(text: 'На карте')
            ],
          ),
          title: Container(
            child: Center(
              child: Text(
                'Маршрут детально',
              ),
            ),
            margin: EdgeInsets.only(right: 48),
          ),
        ),
        body: Container(
          child: FutureBuilder<Direction>(
            future: getDetail(this.dirId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text(
                      'Error:\n\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    );
                  return TabBarView(
                    children: [
                      _detailPage(snapshot),
                      Icon(Icons.directions_bus),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _detailPage(AsyncSnapshot snapshot) {
    List ostList = snapshot.data.ostList;
    List firstStopDays=snapshot.data.firstStopInfo['data']['_${snapshot.data.transportName}']['directions']['_${this.dirId}']['days'];
    print(firstStopDays[1]['timelist']);

    return Column(
      children: <Widget>[
        Text(
          'Отправление от  ${ostList[0].name}',
        ),
        Container(
          child: _timeListTabs(firstStopDays),
        ),
        Expanded(
          child: Container(
            child: _ostScroll(ostList),
          ),
        ),
      ],
    );
  }

  _buildExpandableContent(List ostList) {
    ostList.removeAt(0);
    List<Widget> columnContent = [];
    ostList.forEach((element) => {
          columnContent.add(
            new ListTile(
              title: new Text(
                element.name,
                style: new TextStyle(fontSize: 18.0),
              ),
            ),
          )
        });
    return columnContent;
  }

  Widget _timeListTabs(List timeLists){
    List<Widget> tabs=[];
    List<Widget> tabviews=[];
    timeLists.forEach((element) => {
      tabs.add(Text( element['plan_content_name'])),
      tabviews.add(
        Container(

          child: Text(element['timelist']),
      ),
      )});
    return DefaultTabController(
      length: timeLists.length,
      child: Expanded(
        child: Column(
          children: <Widget>[
            Container(
              //constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                  labelColor: const Color(0xFF3baee7),
                  labelPadding: EdgeInsets.all(0),
                  isScrollable: false,
                  tabs: tabs),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                    children: tabviews,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ostScroll(List stops) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(_buildExpandableContent(stops)),
      ),
    ]);
  }
}
