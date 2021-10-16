import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DaysApi _user;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: _user == null? Container():Text("days ${_user.days}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final String leave_type = "8";
          final String start_date = "12-10-2021";
          final String end_date = "14-10-2021";


          final DaysApi user = await UserLeave(leave_type,start_date,end_date);

          setState(() {
            _user = user;
          });

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<DaysApi> UserLeave(String leave_type,String start_date, String end_date) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body:
      jsonEncode({
        "employee_id": "14",
        "leave_type":leave_type,
        "start_date":start_date,
        "end_date":end_date
      }));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return daysApiFromJson(responseString);
  } else {
    return null;
  }

}


DaysApi daysApiFromJson(String str) => DaysApi.fromJson(json.decode(str));

String daysApiToJson(DaysApi data) => json.encode(data.toJson());

class DaysApi {
  DaysApi({
    this.days,
  });

  String days;

  factory DaysApi.fromJson(Map<String, dynamic> json) => DaysApi(
    days: json["days"],
  );

  Map<String, dynamic> toJson() => {
    "days": days,
  };
}
