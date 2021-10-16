//import 'package:app_hrms/drawer/drawe_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
//import 'package:app_hrms/main.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class DemoDisplay extends StatefulWidget {
  const DemoDisplay({Key key}) : super(key: key);

  @override
  _DemoDisplayState createState() => _DemoDisplayState();
}

class _DemoDisplayState extends State<DemoDisplay> {
  UpdateModel _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 100,),
            ElevatedButton(onPressed: ()async{
              _user = await createUser('IN');
              setState(() {

              });

            }, child: Text("send")),
            _user == null? Text("no data"):Text("status ${_user.log_type}"
                " and time is ${_user.time} ")
          ],
        ),
      ),
    );
  }
}



Future<UpdateModel> createUser(String logtype) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body:
      jsonEncode({"emp_id": "1", "log_type": logtype, "created_by": "2"}));

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return updateModelFromJson(responseString);
  } else {
    return null;
  }
}

UpdateModel updateModelFromJson(String str) =>
    UpdateModel.fromJson(json.decode(str));

String updateModelToJson(UpdateModel data) => json.encode(data.toJson());

class UpdateModel {
  UpdateModel({this.log_type, this.time});

  String log_type;
  String time;

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
    log_type: json["log_type"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "log_type": log_type,
    "time": time,
  };
}
