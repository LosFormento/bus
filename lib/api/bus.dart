import 'dart:convert';

import 'package:esol_bus_2/models/direction.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
String url = 'here is url';

Future<Direction> getDetail(String dirId) async{

  final response = await http.get('$url/direction_app_json.php?dbid=$dirId');
  var stops=jsonDecode(response.body);
  var stopId=stops['ost_list'][0]['ost_id'];
  final responseFirstStop = await http.get('$url/timetables2_app_json.php?id=$stopId&dir_id=$dirId');
  print('dirId:$dirId, ost_id:$stopId');

  return responseFromJson(response.body,responseFirstStop.body);
}
Future<List> getStopDetail(String stopId) async{
  final responseStop = await http.get('$url/timetables2_app_json.php?id=$stopId');
  print('ost_id:$stopId');
  return jsonDecode(responseStop.body);
}
