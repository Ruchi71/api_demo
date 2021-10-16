
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Demo extends StatefulWidget {
  const Demo({Key key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
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
      drawer: Drawer(),
      body:listOfResponse == null
          ? Container():
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,30,15,0),
          child: Container(
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
            child: DataTable(
              //headingRowColor: MaterialStateProperty.all(kPrimaryColor),
                columnSpacing: 38.0,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Leave Type',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Current Leave',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ],
              rows: List.generate(listOfResponse.length, (index) {
                final y = listOfResponse[index]['type'];
                final x = listOfResponse[index]['current_leave'];
                final z = listOfResponse[index]['can_applied'];
                return DataRow(cells: [
                  DataCell(Container(width: 75, child: Text(y,style: TextStyle(fontWeight: FontWeight.bold
                  ,color: Colors.blue[900])))),
                  DataCell(Container(child: Text(x))),
                  DataCell(Container(child: z.toString() == "Y"?Icon(Icons.app_registration,
                    color: Colors.blue[900],
                    size: 26,):Text('Leave Applied',style: TextStyle(

                      color: Colors.grey[800]
                  ),),)),
                ]);

              })
            ),
          ),
        ),
      )
    );
  }
}
