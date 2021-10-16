//import 'package:app_hrms/drawer/drawe_section.dart';
//import 'package:app_hrms/leave/leave_form.dart';
import 'package:api_demo/leave_folder/leave_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:app_hrms/main.dart';

class LeaveApi extends StatefulWidget {
  const LeaveApi({Key key}) : super(key: key);

  @override
  _LeaveApiState createState() => _LeaveApiState();
}

class _LeaveApiState extends State<LeaveApi> {

  final String apiUrl = "";

  Future<List<dynamic>> fetchUsers() async {

    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kPrimaryColor,
        title: Center(child: Text('Leave Apply')),
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
      body:Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(25,30,25,0),
                      child: Container(
                        height: 90,
                        width: 370,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                //color: kSec.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5
                            ),],

                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15,10,30,10),
                                  child: Text(snapshot.data[index]['type'],style: TextStyle(
                                      fontSize: 18,
                                      color:Colors.blue[900],
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                snapshot.data[index]['can_applied']== "Y"?
                                snapshot.data[index]['type'] == "Sick Leave"?Padding(
                                  padding: const EdgeInsets.fromLTRB(108,0,25,0),
                                  child: IconButton(
                                    onPressed: () {
                                     Navigator.push(context,
                                          MaterialPageRoute(builder: (BuildContext context) =>
                                              LeaveForm(type: snapshot.data[index]["type"],
                                                  id: snapshot.data[index]["id"])));
                                    },
                                    icon: Icon(Icons.app_registration,
                                      color: Colors.blue[900],
                                      size: 30,),
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.fromLTRB(88,0,25,0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (BuildContext context) =>
                                              LeaveForm(type: snapshot.data[index]["type"],
                                                  id: snapshot.data[index]["id"])));
                                    },
                                    icon: Icon(Icons.app_registration,
                                      color: Colors.blue[900],
                                      size: 30,),
                                  ),
                                ): Padding(
                                  padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                  child: Text('Leave Applied',style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.green
                                  ),),
                                ),

                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.grey[500],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15,10,0,10),
                                  child: Text('Current Leave',style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800]
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(130,10,25,10),
                                  child: Text(snapshot.data[index]['current_leave'].toString(),style: TextStyle(
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
                    )
                    ;
                  });
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },


        ),
      ),
    );
  }
}

