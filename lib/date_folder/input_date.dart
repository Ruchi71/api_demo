//import 'package:app_hrms/drawer/request/certificate/apply_certificate.dart';
//import 'package:app_hrms/main.dart';
import 'package:api_demo/date_folder/display_date.dart';
import 'package:api_demo/date_folder/display_provider.dart';
import 'package:api_demo/date_folder/display_provider.dart';
import 'package:api_demo/date_folder/display_provider.dart';
import 'package:api_demo/date_folder/display_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CertificateProvider extends StatefulWidget {
  const CertificateProvider({Key key}) : super(key: key);

  @override
  _CertificateProviderState createState() => _CertificateProviderState();
}

class _CertificateProviderState extends State<CertificateProvider> {
  final String apiUrl =
      "";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }
  String formatter = DateFormat.yMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kPrimaryColor,
        title: Center(child: Text('Document Request')),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Container(
                    height: 308,
                    width: 370,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            //color: kSec.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5),
                      ],
                    ),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  snapshot.data[index]['certificate_name'] == 'NOC\/ Visa Application Salary Certificate'?
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15,10,30,10),
                                    child: Text("NOC/Visa Application \nSalary Certificate",style: TextStyle(
                                        fontSize: 18,
                                        color:Colors.blue[900],
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15,10,30,8),
                                    child: Text(snapshot.data[index]['certificate_name'],style: TextStyle(
                                        fontSize: 18,
                                        color:Colors.blue[900],
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                  snapshot.data[index]['certificate_name'] == "Employment Letter"
                                      || snapshot.data[index]['certificate_name'] ==  "Immigration Letter"?
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(60,0,30,0),
                                    child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) =>
                                                DisProvider(certificate_name: snapshot.data[index]["certificate_name"],
                                                    id: snapshot.data[index]["id"],date:formatter)));
                                      },
                                      icon: Icon(Icons.app_registration,
                                        color: Colors.blue[900],
                                        size: 30,),
                                    ),
                                  ):
                                  snapshot.data[index]['certificate_name'] == "Salary Transfer Letter"
                                      || snapshot.data[index]['certificate_name'] ==  "NOC\/ Visa Application Salary Certificate"?
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                    child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) =>
                                                DisProvider(certificate_name: snapshot.data[index]["certificate_name"],
                                                    id: snapshot.data[index]["id"],date:formatter)));
                                      },
                                      icon: Icon(Icons.app_registration,
                                        color: Colors.blue[900],
                                        size: 30,),
                                    ),
                                  ):
                                  snapshot.data[index]['certificate_name'] == "Muroor Letter"?
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(96,0,30,0),
                                    child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) =>
                                                DisProvider(certificate_name: snapshot.data[index]["certificate_name"],
                                                    id: snapshot.data[index]["id"],date:formatter)));
                                      },
                                      icon: Icon(Icons.app_registration,
                                        color: Colors.blue[900],
                                        size: 30,),
                                    ),
                                  ):
                                  snapshot.data[index]['certificate_name'] == "Salary Certificate"?
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(68,0,30,0),
                                    child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) =>
                                                DisProvider(certificate_name: snapshot.data[index]["certificate_name"],
                                                    id: snapshot.data[index]["id"],date:formatter)));
                                      },
                                      icon: Icon(Icons.app_registration,
                                        color: Colors.blue[900],
                                        size: 30,),
                                    ),
                                  ):

                                  Container()
                                ],
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                                color: Colors.grey[500],
                              ),
                            ],
                          );
                        }),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
