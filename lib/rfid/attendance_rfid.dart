import 'package:api_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AttendP extends StatefulWidget {
  const AttendP({Key key}) : super(key: key);

  @override
  _AttendPState createState() => _AttendPState();
}

class _AttendPState extends State<AttendP> {
  DateTime now = DateTime.now();
  String formatedtime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Center(child: Text('RF id Attendance')),
      ),
        body: ChangeNotifierProvider<MyModel>(
            create: (context) => MyModel(),
            child: Builder(builder: (context) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Consumer<MyModel>(builder: (context, myModel, child) {
                            return Container(
                              width: 250,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: kSec.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                  controller: myModel.rfController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    hintText: 'RFid',
                                  )),
                            );
                          }),
                          Consumer<MyModel>(builder: (context, myModel, child) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                              child: Container(
                                height: 40,

                                child: ElevatedButton(
                                    onPressed: () async {
                                      await myModel.getdata();
                                    },
                                    child: Text("submit",style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStateProperty
                                    .all(kPrimaryColor,),)),
                              ),
                            );
                          }),
                        ],
                      ),

                      Consumer<MyModel>(builder: (context, myModel, child) {
                        return myModel._user == null
                            ? Container()
                            : myModel._user.status == "success"
                                ? Consumer<MyModel>(builder: (context, myModel, child) {
                          return myModel._model == null || myModel._model.log_type == "OUT"
                              ? Padding(
                            padding: const EdgeInsets.fromLTRB(25, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                //await myModel.getLocation();
                                //await myModel.getdatain();
                                final UpdateModel user = await createUserlog('IN');
                                myModel.getlogdata(user);
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
                                      padding: const EdgeInsets.fromLTRB(5, 18, 0, 8),
                                      child: Text(
                                        formatedtime,
                                        style: TextStyle(fontSize: 16, color: Colors.white),
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
                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Text(
                                        "Punch\n   IN",
                                        style: TextStyle(fontSize: 23, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                //await myModel.getLocation();
                                //await myModel.getdataout();
                                final UpdateModel user = await createUserlog('OUT');
                                myModel.getlogdata(user);
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
                                      padding: const EdgeInsets.fromLTRB(5, 18, 0, 8),
                                      child: Text(
                                        formatedtime,
                                        style: TextStyle(fontSize: 16, color: Colors.white),
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
                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Text(
                                        "Punch\n OUT",
                                        style: TextStyle(fontSize: 23, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                                : Text("failed");
                      }),
                      
                    ],
                  ),
                ),
              );
            })));
  }
}

class MyModel with ChangeNotifier {
  UserModel _user;
  UpdateModel _model;
  String rf;
  final TextEditingController rfController = TextEditingController();

  void getdata() async {
    final String rf = rfController.text;
    final UserModel userdata = await createUser(rf);
    _user = userdata;
    notifyListeners();
  }

  void getlogdata(user) {
    _model = user;
    notifyListeners();
  }
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
  UserModel({
    this.status,
  });

  String status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

Future<UpdateModel> createUserlog(String log_type) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body:
          jsonEncode({"emp_id": "1", "log_type": log_type, "created_by": "2"}));

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
