import 'package:api_demo/attendance/attendance_location.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AttendRf extends StatefulWidget {
  const AttendRf({Key key}) : super(key: key);

  @override
  _AttendRfState createState() => _AttendRfState();
}

class _AttendRfState extends State<AttendRf> {

  DateTime now = DateTime.now();
  String formatedtime = DateFormat('hh:mm a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider<Attend>(
        create: (context) => Attend(),
        child: Builder(
    builder: (context) {
          return Container(
            child: Column(
              children: [
                Consumer<Attend>(builder: (context, attend, child) {
                  return TextField(
                      controller: attend.rfController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'RFid',
                      ));
                }),
                Consumer<Attend>(builder: (context, attend, child) {
                  return ElevatedButton(
                      onPressed: ()async{
                        attend.rf = attend.rfController.text;
                        final AttendModel user = await createUser(attend.rf);
                        attend.getdata(user);
                        final snackbarfail = SnackBar(content: Text("failed"));
                        attend._attendModel.status == "success"?
                            Text("success"):
                        //await buildConsumerlog():
                        Scaffold.of(context).showSnackBar(snackbarfail);
                      },
                      child: Text("submit"));
                })

              ],
            ),
          );}
        ),
      ),
    );
  }

 /* Future<Consumer<MyModel>> buildConsumerlog() async {
    return Consumer<MyModel>(builder: (context, myModel, child) {
                        return myModel._model == null || myModel._model.log_type == "OUT"
                            ? Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
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
                        )
                            : Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              //await myModel.getLocation();
                              //await myModel.getdataout();
                              final UpdateModel userlog = await createUserlog('OUT');
                              attend.getdata(userlog);
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
                        );
                      });
  }*/
}

class Attend with ChangeNotifier {
  AttendModel _attendModel;
  UpdateModel _user;
  String rf;
  final TextEditingController rfController = TextEditingController();

  void getdatalog(userlog){
    _user = userlog;
    notifyListeners();
  }

  void getdata(user) {
    _attendModel = user;
    notifyListeners();
  }
}

Future<AttendModel> createUser(String rf) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode({
        "rf": rf,
      }));

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return attendModelFromJson(responseString);
  } else {
    return null;
  }
}

AttendModel attendModelFromJson(String str) =>
    AttendModel.fromJson(json.decode(str));

String attendModelToJson(AttendModel data) => json.encode(data.toJson());

class AttendModel {
  AttendModel({
    this.status,
  });

  String status;

  factory AttendModel.fromJson(Map<String, dynamic> json) => AttendModel(
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


