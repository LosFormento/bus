import 'package:flutter/material.dart';
import 'package:esol_bus_2/models/direction.dart';
import 'package:esol_bus_2/api/bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class DirectionDetailPage extends StatefulWidget {
  @override
  _DirectionDetailPageState createState() => _DirectionDetailPageState();
}

class _DirectionDetailPageState extends State<DirectionDetailPage> {
  String dirId;

  @override

  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    dirId=args['id'];
    //print(args['title']);
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
            child: Text(
              '${args['name']} ${args['title']}',
            ),

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
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _detailPage(snapshot),
                      _mapDirectoryView(snapshot),
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
    //print(firstStopDays[1]['timelist']);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            'Отправление от  ${ostList[0].name}',
          ),
        ),
        Expanded(
          flex: 4,
          child: _timeListTabs(firstStopDays),
        ),
        Expanded(
          flex: 7,
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
    return Container(
      child: DefaultTabController(
        length: timeLists.length,
        child: Column(
          children: <Widget>[
            Container(
              //constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                  labelColor: const Color(0xFF3baee7),
                  labelPadding: EdgeInsets.symmetric(vertical:15,horizontal: 0),
                  isScrollable: false,
                  tabs: tabs),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
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
  
  Widget _mapDirectoryView(snapshot){

    return Container(
         child: GoogleMap(
           mapType: MapType.hybrid,
           initialCameraPosition: CameraPosition(
             target: LatLng(52.792747, 27.543261),
             zoom: 17,
           ),
           onMapCreated: (GoogleMapController controller) {
             Completer();
           },

         ),

    );    
    
  }
  
}
