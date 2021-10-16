/*import 'package:api_demo/demo1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveApi extends StatefulWidget {
  const LeaveApi({Key key}) : super(key: key);

  @override
  _LeaveApiState createState() => _LeaveApiState();
}

class _LeaveApiState extends State<LeaveApi> {
  List listOfResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.post(Uri.parse(''));

    if(response.statusCode==200) {
      setState(() {
        listOfResponse = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
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
      drawer: Drawer(),
      body: listOfResponse == null
          ? Container():
      SingleChildScrollView(
        child: Container(
          height: 1040,
          width: double.infinity,
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25,30,25,0),
                      child: Container(
                        height: 228,
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
                                    child: Text(listOfResponse[index]['type'].toString(),style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ),

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
                                  child: Text('Opening Leave',style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[800]
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(93,10,0,10),
                                  child: Text(listOfResponse[index]['opening_leave'].toString(),style: TextStyle(
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
                                  child: Text('Leave Taken',style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[800]
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(111,10,0,10),
                                  child:Text(listOfResponse[index]['leave_taken'].toString(),style: TextStyle(
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
                                  child: Text('Current Leave',style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800]
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(106,10,0,10),
                                  child: Text(listOfResponse[index]['current_leave'].toString(),style: TextStyle(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25,10,0,10),
                                  child: Text('Action',style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[800]
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(155,5,0,10),
                                  child: listOfResponse[index]['can_applied'].toString() == "Y"
                                      ?IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (BuildContext context) =>
                                              DemoSecond(type: listOfResponse[index]["type"],
                                                  id: listOfResponse[index]["id"])));
                                    },
                                    icon: Icon(Icons.app_registration,
                                      color: Colors.blue[700],
                                      size: 30,),
                                  ): Text('Leave Applied',style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[800]
                                  ),),
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                },
                itemCount: listOfResponse == null ? 0 : listOfResponse.length,
              )

            ],
          ),
        ),
      ),
    );
  }
}*/
