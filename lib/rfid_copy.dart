import 'dart:async';

//import 'package:app_hrms/login/provider_login.dart';
//import 'package:app_hrms/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RfidAtten extends StatefulWidget {
  const RfidAtten({Key key}) : super(key: key);

  @override
  _RfidAttenState createState() => _RfidAttenState();
}

class _RfidAttenState extends State<RfidAtten> {
  DateTime now = DateTime.now();
  String formatedtime = DateFormat('hh:mm a').format(DateTime.now());

  /*@override
  void initState() {
    initial();
    super.initState();
  }

  SharedPreferences logindata;
  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         // backgroundColor: kPrimaryColor,
          title: Center(child: Text('RFID Attendance')),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                 /* logindata.setBool('logincommon', true);
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ProviderLogin()));*/
                },
                child: Text("LogOut"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                  //backgroundColor: MaterialStateProperty.all(kPrim,),
                ),
              ),
            )
          ],
        ),
        body: ChangeNotifierProvider<MyModel>(
          create: (context) => MyModel(),
          child: SingleChildScrollView(
              child: Consumer<MyModel>(builder: (context, myModel, child) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        //color: kSec.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                  controller: myModel.rfController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    hintText: 'RFID No.',
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 30, 20, 0),
                            child: Container(
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await myModel.getdata();
                                    await myModel.lastdata();

                                  },
                                  child: Text(
                                    "submit",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                 /* style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20))),
                                      backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor,
                                      )
                                      )*/
                                      ),
                            ),
                          )
                        ],
                      ),
                      Container(child:
                      myModel._user == null
                          ? Container()
                          : myModel._user.status == "success"
                          ? Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(80, 25, 20, 0),
                            child: Text(
                              "Hello,  ${myModel._user.name}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          myModel._lastModel == null || myModel._lastModel.status == "error" || myModel._lastModel.type == "OUT" ?
                          Padding(
                            padding: const EdgeInsets.fromLTRB(80, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                //await myModel.getLocation();
                                //await myModel.getdatain();
                                final UpdateModel user = await createUserlog("IN");
                                await myModel.getlogdata(user);
                                await myModel.lastdata();
                                Timer(Duration(seconds: 5),(){
                                  myModel.dispose();
                                });

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
                          ):
                          Padding(
                            padding: const EdgeInsets.fromLTRB(80, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                //await myModel.getLocation();
                                //await myModel.getdataout();
                                final UpdateModel user = await createUserlog('OUT');
                                await myModel.getlogdata(user);
                                await myModel.lastdata();
                                Timer(Duration(seconds: 5),(){
                                  myModel.dispose();
                                });

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
                                        "Punch\n OUT",
                                        style: TextStyle(
                                            fontSize: 23, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                          : Container(),),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Container(
                          height: 130,
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
                          child: Column(children: [
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
                                    const EdgeInsets.fromLTRB(170, 10, 20, 10),
                                    child: myModel._lastModel == null
                                        ? Container()
                                        : Text(
                                      myModel._lastModel.type,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.bold),
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
                                    'Last Log',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey[800]),
                                  ),
                                ),
                                Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(150, 10, 20, 10),
                                    child: myModel._lastModel == null
                                        ? Text("")
                                        : Text(
                                      myModel._lastModel.inTime,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.bold),
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
                            Row(children: [
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
                                  const EdgeInsets.fromLTRB(130, 10, 20, 10),
                                  child: myModel._lastModel == null
                                      ? Text("")
                                      : Text(
                                    myModel._lastModel.totalTime,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                          ]),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(160, 30, 0, 0),
                          child: Container(
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  myModel.dispose();
                                },
                                child: Text(
                                  "Clear",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /*style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20))),
                                  backgroundColor: MaterialStateProperty.all(
                                    kPrimaryColor,
                                  ),
                                )
                                */),
                          )),

                    ],
                  ),
                );
              })),
        ));
  }
}

class MyModel with ChangeNotifier {
  UserModel _user;
  UpdateModel _model;
  LastModel _lastModel;
  String rf;
  final TextEditingController rfController = TextEditingController();

  void getdata() async {
    final String rf = rfController.text;
    final UserModel userdata = await createUser(rf);
    _user = userdata;
    notifyListeners();
  }

  void lastdata() async {
    final LastModel lastd = await lastUser();
    _lastModel = lastd;
    notifyListeners();
  }

  void getlogdata(user) {
    _model = user;
    notifyListeners();
  }

  void dispose() {
    rfController.clear();
    _user = null;
    _model = null;
    _lastModel = null;
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
  LastModel({this.inTime, this.type, this.totalTime, this.status});

  String inTime;
  String type;
  String totalTime;
  String status;

  factory LastModel.fromJson(Map<String, dynamic> json) => LastModel(
      inTime: json["in_time"],
      type: json["type"],
      totalTime: json["total_time"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
    "in_time": inTime,
    "type": type,
    "total_time": totalTime,
    "status": status
  };
}

Future<UserModel> createUser(String rf) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode({
        "rf": rf,
      }));

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({this.status, this.name});

  String status;
  String name;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {"status": status, "name": name};
}

Future<UpdateModel> createUserlog(String log_type) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode(
          {"emp_id": "45", "log_type": log_type, "created_by": "2"}));

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
  UpdateModel({this.log_type});

  String log_type;

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
    log_type: json["log_type"],
  );

  Map<String, dynamic> toJson() => {
    "log_type": log_type,
  };
}
