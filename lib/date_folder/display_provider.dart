//import 'package:app_hrms/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DisProvider extends StatefulWidget {
  const DisProvider({Key key, this.certificate_name, this.id, this.date})
      : super(key: key);
  final String certificate_name;
  final String id;
  final String date;

  @override
  _DisProviderState createState() => _DisProviderState();
}

class _DisProviderState extends State<DisProvider> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<MyModel>(
        create: (context) => MyModel(),
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Text(
                      'Certificate Name',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            //color: kSec.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text(
                          widget.certificate_name,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Text(
                      'Apply Date',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            //color: kSec.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text(
                          widget.date,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Text(
                      'Apply Reason',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              //color: kSec.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Consumer<MyModel>(
    builder: (context, myModel, child) {
                        return TextFormField(
                          controller: myModel.notes,
                          decoration: InputDecoration.collapsed(
                            hintText: "Reason",
                          ),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          maxLines: 5,
                        );}
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
                        child: Consumer<MyModel>(
    builder: (context, myModel, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              myModel.certificate_id = widget.id;
                                  myModel.certificate_name = widget.certificate_name;
                                  myModel.apply_date = widget.date;
                                  myModel.apply_notes = myModel.notes.text;
                                  final UserModel user = await createUser(myModel.certificate_id,
                                      myModel.certificate_name, myModel.apply_date, myModel.apply_notes);
                                   myModel.getdata(user);
                              final snackbar = SnackBar(content: Text("successful"));
                              final snackbarfail = SnackBar(content: Text("failed"));
                              myModel._model.status == "success"
                                  ? Scaffold.of(context).showSnackBar(snackbar)
                                  : Scaffold.of(context).showSnackBar(snackbarfail);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Apply',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                              //backgroundColor: MaterialStateProperty
                              //.all(kPrimaryColor,),
                            ),
                          );}
                        )),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  UserModel _model;
  String certificate_id;
  String certificate_name;
  String apply_date;
  String apply_notes;

  final TextEditingController notes = TextEditingController();

  void getdata(user) async {
    /*final String apply_notes = notes.text;
    certificate_id = widget.id;
    certificate_name = widget.certificate_name;
    apply_date = widget.date;

    final UserModel userdata = await createUser(
        certificate_name, certificate_id, apply_notes, apply_date);*/

    _model = user;
    notifyListeners();
  }
}

Future<UserModel> createUser(String certificate_id, String certificate_name,
    String apply_date, String apply_notes) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode({
        "certificate_id": certificate_id,
        "employee_id": "45",
        "certificate_name": certificate_name,
        "apply_date": apply_date,
        "apply_notes": apply_notes,
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
