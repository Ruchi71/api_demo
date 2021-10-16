import 'package:api_demo/rfid/attendance_rfid.dart';
import 'package:api_demo/rfid/homepage.dart';
import 'package:api_demo/rfid/rfid_attend.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider<MyModel>(
              create: (context) => MyModel(),
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Consumer<MyModel>(builder: (context, myModel, child) {
                        return TextField(
                            controller: myModel.nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Username',
                            ));
                      }),
                      SizedBox(height: 30,),
                      Consumer<MyModel>(builder: (context, myModel, child) {
                        return TextField(
                            controller: myModel.passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                            ));
                      }),
                      Consumer<MyModel>(builder: (context, myModel, child) {
                        return ElevatedButton(
                                onPressed: () async {
                                  await myModel.getdata();
                                  final snackbarfail = SnackBar(content: Text("login failed"));
                                  myModel._model.status == true?
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (BuildContext context) =>
                                          Home()))
                                      : myModel._rFidModel.status == "success"?
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (BuildContext context) =>
                                          AttendRf()))
                                  :Scaffold.of(context).showSnackBar(snackbarfail);
                                  },
                                child:Text('Login')
                        );}),
                    ],
                  ),
                );
              }))
    );
  }
}

class MyModel with ChangeNotifier {
  UserModel _model;
  RFidModel _rFidModel;
  String username;
  String password;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void getdata() async {
    final String username = nameController.text;
    final String password = passwordController.text;

    final UserModel userdata = await createUser(username, password);
    final RFidModel commondata = await commonUser(username, password);

    _model = userdata;
    _rFidModel = commondata;
    notifyListeners();
  }
}

Future<UserModel> createUser(String username, String password) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode({"username": username, "password": password}));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(responseString);

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

  bool status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

Future<RFidModel> commonUser(String username, String password) async {
  final String apiUrl =
      "https://blueskyhrms.com/viola_demo/index.php?r=apicommon/login";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode({"username": username, "password": password}));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(responseString);

    return rFidModelFromJson(responseString);
  } else {
    return null;
  }
}

RFidModel rFidModelFromJson(String str) => RFidModel.fromJson(json.decode(str));

String rFidModelToJson(RFidModel data) => json.encode(data.toJson());

class RFidModel {
  RFidModel({
    this.status,
    this.id,
  });

  String status;
  String id;

  factory RFidModel.fromJson(Map<String, dynamic> json) => RFidModel(
    status: json["status"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "id": id,
  };
}

