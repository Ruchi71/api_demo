import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AttendanceMod extends StatefulWidget {
  const AttendanceMod({Key key}) : super(key: key);

  @override
  _AttendanceModState createState() => _AttendanceModState();
}

class _AttendanceModState extends State<AttendanceMod> {
  DateTime now = DateTime.now();
  String formatedtime = DateFormat('hh:mm a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: ChangeNotifierProvider<MyModel>(
        create: (context) => MyModel(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Consumer<MyModel>(builder: (context, myModel, child) {
                return myModel._model == null? Container():myModel._model.type =="OUT"?
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      //await myModel.getLocation();
                      //await myModel.getdatain();
                      final UserModel user = await createUser('IN');
                      myModel.getdata(user);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.blue[900]),
                    child: Container(
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(5, 18, 0, 8),
                            child: Text(
                              formatedtime,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              "Punch\n   IN",
                              style: TextStyle(
                                  fontSize: 23, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ):myModel._model.type =="IN"?
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      //await myModel.getLocation();
                      //await myModel.getdataout();
                      final UserModel user = await createUser('OUT');
                      myModel.getdata(user);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.green),
                    child: Container(
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(5, 18, 0, 8),
                            child: Text(
                              formatedtime,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              "Punch\n OUT",
                              style: TextStyle(
                                  fontSize: 23, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ):Container();
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  height: 240,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        //color: kSec.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5)
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                            child: Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          ),
                          Padding(
                              padding:
                              const EdgeInsets.fromLTRB(200, 10, 20, 10),
                              child: Consumer<MyModel>(
                                builder: (context, myModel, child) {
                                  return myModel._user == null
                                      ? Container()
                                      : Text(
                                    myModel._model.type,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey[500],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                            child: Text(
                              'IN Time',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          ),
                          Padding(
                              padding:
                              const EdgeInsets.fromLTRB(150, 10, 20, 10),
                              child: Consumer<MyModel>(
                                builder: (context, myModel, child) {
                                  return myModel._model == null
                                      ? Container()
                                      : Text(
                                    myModel._model.inTime,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey[500],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                            child: Text(
                              'Total Hours',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          ),
                          Padding(
                              padding:
                              const EdgeInsets.fromLTRB(150, 10, 20, 10),
                              child: Consumer<MyModel>(
                                builder: (context, myModel, child) {
                                  return myModel._model == null
                                      ? Container()
                                      : Text(
                                    myModel._model.totalTime,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  //                          <--- MyModel
  //var locationmessage = "";
  UserModel _user;
  LastModel _model;

  /*void getLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var long = position.longitude;

    locationmessage = "latitude: $lat, longitude: $long";
    notifyListeners();
  }*/

  /* void getdatain() async {
    final UpdateModel userin = await createUser("IN");
    _user = userin;
    notifyListeners();
  }

  void getdataout() async {
    final UpdateModel userout = await createUser("OUT");
    _user = userout;
    notifyListeners();
  }*/
  void getdata(user) {
    _user = user;
    notifyListeners();
  }
}

Future<LastModel> lastUser() async {
  final String apiUrl =
      "";

  final response =
      await http.post(Uri.parse(apiUrl), body: jsonEncode({"emp_id": "45"}));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print('responnse status:${response.statusCode}');
    print('response body: ${responseString}');

    return lastModelFromJson(responseString);
  } else {
    return null;
  }
}

LastModel lastModelFromJson(String str) => LastModel.fromJson(json.decode(str));

String lastModelToJson(LastModel data) => json.encode(data.toJson());

class LastModel {
  LastModel({
    this.inTime,
    this.type,
    this.totalTime,
  });

  String inTime;
  String type;
  String totalTime;

  factory LastModel.fromJson(Map<String, dynamic> json) => LastModel(
        inTime: json["in_time"],
        type: json["type"],
        totalTime: json["total_time"],
      );

  Map<String, dynamic> toJson() => {
        "in_time": inTime,
        "type": type,
        "total_time": totalTime,
      };
}

Future<UserModel> createUser(String log_type) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode(
          {"emp_id": "45", "log_type": log_type, "created_by": "2"}));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print('responnse status:${response.statusCode}');
    print('response body: ${responseString}');

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.logType,
  });

  String logType;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        logType: json["log_type"],
      );

  Map<String, dynamic> toJson() => {
        "log_type": logType,
      };
}
