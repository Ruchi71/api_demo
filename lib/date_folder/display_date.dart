//import 'package:app_hrms/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApplyCertificate extends StatefulWidget {
  const ApplyCertificate({Key key, this.certificate_name, this.id, this.date})
      : super(key: key);
  final String certificate_name;
  final String id;
  final String date;

  @override
  _ApplyCertificateState createState() => _ApplyCertificateState();
}

class _ApplyCertificateState extends State<ApplyCertificate> {
  String certificate_id;
  String certificate_name;
  String apply_date;
  String apply_notes;
  UserModel _model;
  final TextEditingController notes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Apply For Certificate'),
      ),
      body: Builder(
        builder: (context){
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
                    child: TextFormField(
                      controller: notes,
                      decoration: InputDecoration.collapsed(
                        hintText: "Reason",
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      maxLines: 5,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          certificate_id = widget.id;
                          certificate_name = widget.certificate_name;
                          apply_date = widget.date;
                          apply_notes = notes.text;
                          final UserModel user = await createUser(certificate_id,
                              certificate_name, apply_date, apply_notes);
                          setState(() {
                            _model = user;
                          });
                          final snackbar = SnackBar(content: Text("successful"));
                          final snackbarfail = SnackBar(content: Text("failed"));
                          _model.status == "success"
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
                      )),
                ),
              ],
            ),
          ),
        );}
      ),
    );
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
