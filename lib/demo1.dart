import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DemoSecond extends StatefulWidget {
  const DemoSecond({Key key, this.type,this.id}) : super(key: key);
  final String type;
  final String id;

  @override
  _DemoSecondState createState() => _DemoSecondState();
}

class _DemoSecondState extends State<DemoSecond> {
  DaysApi _daysApi;
  String leave_type;
  String start_date;
  String end_date;
  @override
  Widget build(BuildContext context) {
    Text txt = Text(widget.id);
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Leave Apply'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("leave type:- ${widget.type}",style: TextStyle(fontSize: 20),),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Start Date',style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(width: 70,),
                  Text('End Date',style: TextStyle(fontSize: 20)),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child: Container(
                      child: Consumer<MyModel>(
                          builder: (context, myModel, child) {
                            return ElevatedButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: myModel._startdate == null
                                        ? DateTime.now()
                                        : myModel._startdate,
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2031)
                                ).then((date) {
                                  myModel.StartDate(date);
                                });
                              },
                              child: Consumer<MyModel>(
                                  builder: (context, myModel, child) {
                                    return Text(
                                      myModel._startdate == null ? ''
                                          : myModel.dateformate.
                                      format(myModel._startdate),

                                    );
                                  }),
                            );
                          }
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                    child: Container(
                      child: Consumer<MyModel>(
                          builder: (context, myModel, child) {
                            return ElevatedButton(
                              onPressed: () async {
                                showDatePicker(
                                    context: context,
                                    initialDate: myModel._enddate == null
                                        ? DateTime.now()
                                        : myModel._enddate,
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2031)
                                ).then((date)async{
                                  myModel.EndDate(date);
                                  leave_type = txt.data;
                                  start_date = myModel.dateformate.format(myModel._startdate);
                                  end_date = myModel.dateformate.format(myModel._enddate);
                                  final DaysApi user = await UserLeave(leave_type,start_date,end_date);

                                  setState(() {
                                    _daysApi = user;
                                  });
                                });

                              },
                              child: Consumer<MyModel>(
                                  builder: (context, myModel, child) {
                                    return Text(myModel._enddate == null ? ''
                                        : myModel.dateformate
                                        .format(myModel._enddate),
                                    );
                                  }),
                            );
                          }
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("days",style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: _daysApi == null? Container(): Text(_daysApi.days,style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyModel with ChangeNotifier {//                          <--- MyModel
  DateTime _startdate;
  DateTime _enddate;
  final dateformate = DateFormat("dd-MM-yyyy");
  String leave_type;

  void StartDate(date) {
    _startdate = date;
    notifyListeners();
  }
  void EndDate(date) {
    _enddate = date;
    notifyListeners();
  }
}

Future<DaysApi> UserLeave(String leave_type, start_date, end_date) async {
  final String apiUrl =
      "";

  final response = await http.post(Uri.parse(apiUrl),
      body:
      jsonEncode({
        "employee_id": "14",
        "leave_type":leave_type.toString(),
        "start_date":start_date.toString(),
        "end_date":end_date.toString()
      }));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return daysApiFromJson(responseString);
  } else {
    return null;
  }

}

// To parse this JSON data, do
//
//     final daysApi = daysApiFromJson(jsonString);

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
