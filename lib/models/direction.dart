import 'dart:convert';

///Use this https://app.quicktype.io/ converter tool to create your ///data class according to the JSON response.
///API used here is - https://jsonplaceholder.typicode.com/posts/1

///Used to map JSON data fetched from the server
Direction responseFromJson(String jsonString,String jsonFirstStop) {

  final jsonData = json.decode(jsonString);
  final jsonFirstStopData = json.decode(jsonFirstStop);
  return Direction.fromJson(jsonData,jsonFirstStopData);
}

class Direction {
  String routePoints;
  String transportName;
  String transportType;
  String dirTitle;
  List<OstList> ostList;
  Map<String, dynamic> firstStopInfo;
  String from;
  double time;

  Direction(
      {this.routePoints,
        this.transportName,
        this.transportType,
        this.dirTitle,
        this.ostList,
        this.from,
        this.time,
        this.firstStopInfo
      });


  Direction.fromJson(Map<String, dynamic> json ,Map<String, dynamic> firstStop) {
    routePoints = json['route_points'];
    transportName = json['transport_name'];
    transportType = json['transport_type'];
    dirTitle = json['dir_title'];
    firstStopInfo = firstStop;

    if (json['ost_list'] != null) {
      ostList = new List<OstList>();
      json['ost_list'].forEach((v) {
        ostList.add(new OstList.fromJson(v));
      });
    }
    from = json['from'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_points'] = this.routePoints;
    data['transport_name'] = this.transportName;
    data['transport_type'] = this.transportType;
    data['dir_title'] = this.dirTitle;
    if (this.ostList != null) {
      data['ost_list'] = this.ostList.map((v) => v.toJson()).toList();
    }
    data['from'] = this.from;
    data['time'] = this.time;
    return data;
  }
  void setFirstStop(Map<String, dynamic> data){
    this.firstStopInfo=data;
  }
}

class OstList {
  String ostId;
  String ord;
  String name;
  String comment;

  OstList({this.ostId, this.ord, this.name, this.comment});

  OstList.fromJson(Map<String, dynamic> json) {
    ostId = json['ost_id'];
    ord = json['ord'];
    name = json['name'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ost_id'] = this.ostId;
    data['ord'] = this.ord;
    data['name'] = this.name;
    data['comment'] = this.comment;
    return data;
  }
}
