import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExternalCircular extends StatefulWidget {
  const ExternalCircular({Key key}) : super(key: key);

  @override
  _ExternalCircularState createState() => _ExternalCircularState();
}

class _ExternalCircularState extends State<ExternalCircular> {
  final String apiUrl =
      "";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kPrimaryColor,
        title: Center(child: Text('External Circular')),
      ),
      body: Container(
          child: FutureBuilder<List<dynamic>>(
              future: fetchUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0,25,0,0),
                          child: Container(
                            height: 60,
                            width: 370,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    //color: kSec.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5
                                ),],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20,10,10,10),
                              child: Text(snapshot.data[index]['notes'],style: TextStyle(
                                  fontSize: 18,
                                  color:Colors.blue[900],

                              )),
                            ),

                          ),
                        );
                      });
                } else {
                  return Center(child: Text("No Data Available"));
                }
              })),
    );
  }
}
