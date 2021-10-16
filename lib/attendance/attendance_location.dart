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

class UserProvider extends StatefulWidget {
  const UserProvider({Key key}) : super(key: key);

  @override
  _UserProviderState createState() => _UserProviderState();
}

class _UserProviderState extends State<UserProvider> {
  DateTime now = DateTime.now();
  String formatedtime = DateFormat('hh:mm a').format(DateTime.now());
  //UpdateModel _user;
  /*SharedPreferences logindata;
  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    initial();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: kPrimaryColor,
          title: Center(child: Text('HR App')),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
        //drawer: MyDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Consumer<MyModel>(builder: (context, myModel, child) {
                return myModel._user == null || myModel._user.log_type == "OUT"
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            //await myModel.getLocation();
                            //await myModel.getdatain();
                            final UpdateModel user = await createUser('IN');
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
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            //await myModel.getLocation();
                            //await myModel.getdataout();
                            final UpdateModel user = await createUser('OUT');
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
                      );
              }),
              /* Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: kPrimaryColor,
                      size: 25,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Consumer<MyModel>(//                    <--- Consumer
                          builder: (context, myModel, child) {
                            return Text(myModel.locationmessage);
                          })),
                ],
              ),*/
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
                                          myModel._user.log_type,
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
                              'Last Log',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          ),
                          Padding(
                              padding:
                              const EdgeInsets.fromLTRB(150, 10, 20, 10),
                              child: Consumer<MyModel>(
                                builder: (context, myModel, child) {
                                  return myModel._user == null
                                      ? Text("NO")
                                      : Text(
                                    myModel._user.time,
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
                            padding: const EdgeInsets.fromLTRB(90, 10, 0, 10),
                            child: Text(
                              '',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          )
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
                              'Punch In',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(110, 10, 0, 10),
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          )
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
                              'Punch Out',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[800]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(90, 10, 0, 10),
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[800]),
                            ),
                          )
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
  UpdateModel _user;

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
  void getdata(user){
    _user = user;
    notifyListeners();
  }
}

Future<UpdateModel> createUser(String log_type) async {
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
