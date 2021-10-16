import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'attendance_api.dart';
import 'attendance_model_class.dart';


class OneButton extends StatefulWidget {
  const OneButton({Key key}) : super(key: key);

  @override
  _OneButtonState createState() => _OneButtonState();
}

class _OneButtonState extends State<OneButton> {
  UpdateModel _user;
  DateTime now = DateTime.now();
  String formatedtime = DateFormat('hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
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
      drawer: Drawer(),
      body: Container(
        height: 900,
        width: double.infinity,
        color: Colors.grey[200],
        child: Column(
          children: [
            _user == null || _user.log_type == "OUT"
                ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  final UpdateModel user = await createUser("IN");
                  setState(() {
                    _user = user;
                  });
                },

                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.green),
                child: Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle,boxShadow: [
                    BoxShadow(
                        color: Colors.green.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 5),
                  ],),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 18, 0, 8),
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
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                  onPressed: () async{
                    final UpdateModel user = await createUser("OUT");
                    setState(() {
                      _user = user;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.green),
                  child: Container(
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle,boxShadow: [
                      BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5),
                    ],),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 18, 0, 8),
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
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                            "Punch\n  OUT",
                            style: TextStyle(
                                fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,20,10,0),
              child: Container(
                height: 170,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue[200].withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5
                    ),],

                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25,10,0,10),
                          child: Text('Status',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[800]
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(200,10,0,10),
                            child: _user == null? Container():Text("${_user.log_type}",style: TextStyle(
                                fontSize: 17,
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),)
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
                          padding: const EdgeInsets.fromLTRB(25,10,0,10),
                          child: Text('Total Hours',style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[800]
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90,10,0,10),
                          child: Text('',style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[800]
                          ),),
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
                          padding: const EdgeInsets.fromLTRB(25,10,0,10),
                          child: Text('Punch In',style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[800]
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(110,10,0,10),
                          child:Text("",style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[800]
                          ),
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
                          padding: const EdgeInsets.fromLTRB(25,10,0,10),
                          child: Text('Punch Out',style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800]
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90,10,0,10),
                          child: Text("",style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[800]
                          ),
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
    );
  }
}
